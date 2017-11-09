require "test_helper"

describe RentalsController do
  describe "check-out" do
    let(:rental_data) {
      {customer_id: customers(:shelley).id, movie_id: movies(:robin_hood).id}
    }

    it "creates a new rental" do
      proc{post checkout_path(rental_data)}.must_change('Rental.count', 1)
      must_respond_with :ok
    end

    it "rents the movie" do
      movie = movies(:robin_hood)
      before = movie.out
      post checkout_path(rental_data)
      movie.reload
      movie.out.must_equal (before + 1)
    end

    it "returns json with the id of the rental created" do
      post checkout_path(rental_data)

      body = JSON.parse(response.body)
      rental_id = Rental.last.id

      body["id"].must_equal rental_id
    end

    it "returns an error for an invalid rental" do
      proc{post checkout_path({})}.must_change('Rental.count', 0)

      body = JSON.parse(response.body)
      body["ok"].must_equal false
      must_respond_with :bad_request
    end

    it "doesn't rent the movie if given invalid rental data" do
      movie = movies(:psycho)
      before = movie.out

      post checkout_path({movie: movie})

      movie.out.must_equal before
    end

    it "won't create a Rental object if movie is unavailable" do
      movie = movies(:robin_hood)
      movie.out = movie.inventory
      movie.save

      proc{post checkout_path(rental_data)}.must_change('Rental.count', 0)
    end
  end # checkout

  describe "check_in" do
    # let(:rental_data) {
    #   {customer_id: customers(:shelley).id, movie_id: movies(:psycho).id}
    # }
    let(:rental) {rentals(:rental1)}

    it "checks in a rental" do
      post check_in_path({customer_id: rental.customer.id, movie_id: rental.movie.id})
      rental.reload
      rental.check_in.must_equal Date.today.strftime("%Y-%m-%d")
    end

    it "increases the movies available inventory" do
      movie = movies(:psycho)
      before = movie.out
      post check_in_path({customer_id: rental.customer.id, movie_id: rental.movie.id})
      movie.reload
      movie.out.must_equal (before - 1)
    end

    it "returns json with the id of the returned rental" do
      post check_in_path({customer_id: rental.customer.id, movie_id: rental.movie.id})

      new_rental = Rental.find_rental(customer_id: rental.customer.id, movie_id: rental.movie.id)

      body = JSON.parse(response.body)
      rental_id = rental.id

      body["id"].must_equal rental_id
    end

    it "returns an error for an invalid check_in" do
      post check_in_path({})

      body = JSON.parse(response.body)
      body["ok"].must_equal false
      must_respond_with :bad_request
    end

  end
end
