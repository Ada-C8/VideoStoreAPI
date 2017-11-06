require "test_helper"

describe Customer do
  let(:harry) { customers(:harry) }
  let(:sally) { customers(:sally) }

  describe "validations" do
    it "must have a name" do
      harry.name = nil
      harry.valid?.must_equal false
    end

    it "must have a phone num" do
      sally.phone = nil
      sally.valid?.must_equal false
    end
  end

  describe "relationships" do
    it "must have a collection of rentals" do
      harry.must_respond_to :rentals
      harry.rentals.length.must_equal 1
      harry.rentals[0].must_be_kind_of Rental
    end

    it "must have a collection of movies" do
      sally.must_respond_to :movies
      sally.movies[0].must_be_instance_of Movie
    end
  end
end
