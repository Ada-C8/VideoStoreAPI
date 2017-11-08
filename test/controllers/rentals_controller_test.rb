require "test_helper"

describe RentalsController do
  let(:c) {Customer.first}
  let(:m) {Movie.first}
  let(:rental_data) {
    {
      customer_id: c.id,
      movie_id: m.id
    }
  }
  describe "checkout" do
    it "will create a new instance of rental" do
      # arrange
      start_count = Rental.count
      availible = m.available_inventory
      num_movies = c.movies_checked_out_count

      # Act
      post rentals_path, params: {rental: rental_data}

      # Assert
      Rental.count.must_equal start_count + 1
      m.available_inventory.must_equal availible - 1
      c.movies_checked_out_count.must_equal num_movies + 1
    end # create a new instance

    it "won't change the db if the request didn't provide the movie_id" do
      rental_data =
      {
        movie_id: m.id
      }

      start_count = Rental.count
      availible = m.available_inventory
      num_movies = c.movies_checked_out_count

      # Act
      post rentals_path, params: {rental: rental_data}

      # Assert
      Rental.count.must_equal start_count
      m.available_inventory.must_equal availible
      c.movies_checked_out_count.must_equal num_movies
    end # without customer_id

    it "won't change the db if the request didn't provide the customer_id" do
      rental_data =
      {
        customer_id: c.id
      }

      start_count = Rental.count
      availible = m.available_inventory
      num_movies = c.movies_checked_out_count

      # Act
      post rentals_path, params: {rental: rental_data}

      # Assert
      Rental.count.must_equal start_count
      m.available_inventory.must_equal availible
      c.movies_checked_out_count.must_equal num_movies
    end # without movie_id

    it "sends the correct data back in the response" do
      keys = ["customer_id", "due_date", "id", "movie_id"]
      post rentals_path, params: {rental: rental_data}

      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
    end
  end # checkout

  describe "checkin" do
    let(:r) {Rental.new(customer_id: c.id,movie_id: m.id)}

    it "will check in a movie if the movie exists" do
          # arrange
          start_count = Rental.count
          availible = m.available_inventory
          num_movies = c.movies_checked_out_count

          r = post rentals_path, params: {rental: rental_data}

          Rental.count.must_equal start_count + 1
          m.available_inventory.must_equal availible - 1
          c.movies_checked_out_count.must_equal num_movies + 1

          r_id = Rental.last.id

          # Act
          patch rental_path(r_id)

          # Assert
          Rental.count.must_equal start_count + 1
          m.available_inventory.must_equal availible
          c.movies_checked_out_count.must_equal num_movies
    end # checkin a movie

    it "will return not_found if rental does not exist" do
      # arrange
      start_count = Rental.count

      r = post rentals_path, params: {rental: rental_data}

      Rental.count.must_equal start_count + 1

      r_id = Rental.last.id + 1

      # Act
      patch rental_path(r_id)

      # Assert
      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_equal "no rental found" => true
    end # not_found
  end # checkin
end # renals
