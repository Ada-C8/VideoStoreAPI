require "test_helper"

describe RentalsController do
  describe "checkout" do
    it "must create a rental record" do
      proc {
        post checkout_path, params: {movie: movies(:dune), customer: customers(:harry)}
      }.must_change 'Rental.count', 1
    end

    it "must set a due_date 5 days in the future" do
      post checkout_path, params: {movie: movies(:gremlins), customer: customers(:sally)}
      rental = Rental.last

      rental.due_date.must_equal Date.now + 5
    end

    it "must decrement the available_inventory for the movie" do
      movie = movies(:gremlins)
      start_inventory = movie.available_inventory
      post checkout_path params: {movie: movie, customer: customers(:harry)}
      movie.available_inventory.must_equal start_inventory - 1
    end

    it "will not create a rental record and will return an error message if the available_inventory is 0" do
      movie = movies(:dune)
      movie.available_inventory = 0
      post checkout_path params: {movie: movie, customer: customers(:sally)}
    end
  end

  describe "checkin" do
    it "must change the value of returned field to true" do
      rental = rentals(:one)
      rental.returned.must_be false
      put checkin_path(rental.id)
      rental.returned.must_be true
    end

    it "must increment the available_inventory of the movie" do
      movie = movies(:gremlins)
      start_inventory = movie.available_inventory
      put checkin_path(rentals(:two).id)
      movie.available_inventory.must_equal start_inventory + 1
    end
  end
end
