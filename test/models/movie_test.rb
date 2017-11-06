require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  it "must be valid" do
    value(movie).must_be :valid?
  end
  describe "relationships" do

  end
  describe "validations" do
  end
end
