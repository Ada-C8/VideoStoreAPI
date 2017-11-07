require "test_helper"

describe RentalsController do
  describe "check-out" do
    it "creates a new rental" do
      proc{post checkout_path(customer_id: customers(:shelley).id, movie_id: movies(:robin_hood).id)}.must_change('Rental.count', 1)
    end

    it "returns json with the id of the rental created" do

    end

    it "returns an error for an invalid rental" do

    end

  end
end
