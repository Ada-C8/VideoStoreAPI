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
      harry.rentals.length.must_equal 2
      harry.rentals[0].must_be_kind_of Rental
    end

    it "must have a collection of movies" do
      sally.must_respond_to :movies
      sally.movies[0].must_be_instance_of Movie
    end
  end

  describe "movies_checked_out_count" do
    # edit once this method is built out
    it "must return the number of movies currently checked out" do
      sally.movies_checked_out_count.must_equal 1
    end

    it "will return 0 if no movies are checked out" do
      rentals(:two).checkin

      harry.movies_checked_out_count.must_equal 0
    end
  end
end
