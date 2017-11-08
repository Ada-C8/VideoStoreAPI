require "test_helper"

describe Rental do

  let (:rental) { rentals(:one) }

  describe "relationships" do

    it "belongs to movie" do
      rental.must_respond_to :movie
    end

    it "belongs to customer" do
      rental.must_respond_to :customer
    end
  end



end
