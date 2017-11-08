require "test_helper"

describe RentalsController do
  let(:rental) {
    {
      movie_id: Movie.first.id,
      customer_id: Customer.first.id,
      due_date: "2017-11-19"
    }
  }

  let(:check_in) {
    {
      movie_id: Rental.last.movie_id,
      customer_id: Rental.last.customer_id
    }
  }

  describe "check_out" do
    it "checks out a movie" do
      # arrange
      before_rental = Rental.count
      before_movie = Movie.find(rental[:movie_id]).available_inventory
      before_movies_rented = Customer.find(rental[:customer_id]).movies_checked_out_count

      # act
      post check_out_path, params: rental

      # assert
      must_respond_with :ok

      # rental count incremented
      Rental.count.must_equal before_rental + 1
      # decrimented available_inventory
      Movie.find(rental[:movie_id]).available_inventory.must_equal before_movie - 1
      # incremented movies_checked_out_count
      Customer.find(rental[:customer_id]).movies_checked_out_count.must_equal before_movies_rented + 1
    end

    it "won't change the db if data is missing" do
      # arrange
      invalid_rental = {
        customer_id: Customer.first.id,
        due_date: "2017-11-19"
      }
      before_movies_rented = Customer.find(invalid_rental[:customer_id]).movies_checked_out_count
      before = Rental.count

      # act
      post check_out_path, params: invalid_rental

      # assert
      Rental.count.must_equal before
      must_respond_with :bad_request

      Customer.find(invalid_rental[:customer_id]).movies_checked_out_count.must_equal before_movies_rented

      body = JSON.parse(response.body)
      body.must_equal "errors" => {"movie" => ["must exist"]}
    end

    it "will return bad request if that movie is unavailable" do
      # arrange
      before = Rental.count
      movie = Movie.find(rental[:movie_id])
      movie.update(available_inventory: 0)

      # act
      post check_out_path, params: rental

      # assert
      must_respond_with :bad_request

      Rental.count.must_equal before

      body = JSON.parse(response.body)
      body.must_equal "errors" => {"movie_id" => "Movie ID: #{rental[:movie_id]} is out of stock and cannot be rented right now. Please try again later"}
    end
  end

  describe "check-in" do
    it "will check in a movie" do
      # # arrange
      post check_out_path, params: rental

      before_movies_rented = Customer.find(rental[:customer_id]).movies_checked_out_count
      Rental.last.returned.must_equal false
      before = Rental.where(returned: false).length
      before_movie = Movie.find(rental[:movie_id]).available_inventory

      # act
      post check_in_path, params: check_in

      # assert
      Customer.find(rental[:customer_id]).movies_checked_out_count.must_equal before_movies_rented - 1
      Movie.find(rental[:movie_id]).available_inventory.must_equal before_movie + 1
      Rental.last.returned.must_equal true
      Rental.where(returned: false).length.must_equal before - 1

      must_respond_with :ok
    end

    it "won't change the db if data is missing" do
      # arrange
      post check_out_path, params: rental
      Rental.last.returned.must_equal false
      before = Rental.where(returned: false).length

      # act
      post check_in_path, params: {movie_id: Rental.last.movie_id}

      # assert
      Rental.last.returned.must_equal false
      Rental.where(returned: false).length.must_equal before
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_equal "errors" => "Rental does not exist."
    end

    it "won't change the db if the movie has already been returned and will send you an error message alerting you" do
      # arrange
      post check_out_path, params: rental
      post check_in_path, params: check_in
      Rental.last.returned.must_equal true
      before = Rental.where(returned: false).length

      # act
      post check_in_path, params: check_in

      # assert
      Rental.last.returned.must_equal true
      Rental.where(returned: false).length.must_equal before
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_equal "errors" => {"movie_id" => "Movie ID: #{rental[:movie_id]} was already returned"}
    end
  end
end
