require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  it "must be valid" do
    value(movie).must_be :valid?
  end

  describe "relations" do
    it "movies has list of rentals" do
      movie = movies(:one)
      movie.must_respond_to :rentals
      movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end

  describe "validations" do
    it "must have title" do
      movie = Movie.new(release_date: "2012-12-21")
      movie.valid?.must_equal false
      movie.errors.messages.must_include :title
    end

    it "must have release_date" do
      movie = Movie.new(title: "test movie")
      movie.valid?.must_equal false
      movie.errors.messages.must_include :release_date
    end
  end
end
