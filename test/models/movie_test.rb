require "test_helper"

describe Movie do
  let(:dune) { movies(:dune) }
  let(:gremlins) { movies(:gremlins) }
  describe "validations" do
    it "must have a title" do
      dune.title = nil
      dune.valid?.must_equal false
    end

    it "must have an inventory that is greater than 0" do
      gremlins.inventory = nil
      gremlins.valid?.must_equal false
      gremlins.inventory = 0
      gremlins.valid?.must_equal false
    end

    it "must have a release date" do
      dune.release_date = nil
      dune.valid?.must_equal false
    end
  end

  describe "relationships" do
    it "must have a collection of rentals" do
      dune.must_respond_to :rentals
      dune.rentals.length.must_equal 1
      dune.rentals[0].must_be_instance_of Rental
    end

    it "must have a collection of customers" do
      gremlins.must_respond_to :customers
      gremlins.customers[0].must_be_instance_of Customer
    end
  end

  describe "available_inventory" do
    it "should be decremented when a copy is checked out (rental creation)" do
      rented = movies(:tnes)
      start_count = rented.available_inventory

      Rental.create!(movie: rented, customer: (customers(:sally)))

      rented.available_inventory.must_equal start_count - 1
    end

    it "should increment when a copy is checked back in" do
      rented = movies(:gremlins)
      start_count = rented.available_inventory

      Rental.find_by(movie_id: rented.id).checkin

      rented.available_inventory.must_equal start_count + 1
    end

  end
end
