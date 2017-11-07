require "test_helper"

describe RentalsController do
  describe "checkout" do
    it "must create a rental record" do
      proc {
        post checkout_path, params: {movie: movies(:dune).id, customer: customers(:harry).id}
      }.must_change 'Rental.count', 1
    end

    it "must set a due_date 5 days in the future" do
      post checkout_path, params: {movie: movies(:gremlins).id, customer: customers(:sally).id}
      rental = Rental.last

      rental.due_date.must_equal Date.today + 5
    end

    it "must decrement the available_inventory for the movie" do
      movie = movies(:gremlins)
      start_inventory = movie.available_inventory
      post checkout_path params: {movie: movie.id, customer: customers(:harry).id}
      movie.available_inventory.must_equal start_inventory - 1
    end

    it "will not create a rental record and will return an error message if the available_inventory is 0" do
      movie = movies(:dune)
      # movie.available_inventory = 0
      post checkout_path params: {movie: movie.id, customer: customers(:sally).id}
    end
  end

  describe "checkin" do
    it "must change the value of returned field to true" do
      rental = rentals(:one)
      rental.returned.must_equal false
      put checkin_path(rental.id)
      rental.reload.returned.must_equal true
    end

    it "must increment the available_inventory of the movie" do
      movie = movies(:gremlins)
      start_inventory = movie.available_inventory
      put checkin_path(rentals(:two).id)
      movie.available_inventory.must_equal start_inventory + 1
    end

    it "must return an error message when attempting to update a returned rental" do
      rental = rentals(:returned)
      put checkin_path(rental.id)
      must_respond_with :bad_request
    end
  end
end
