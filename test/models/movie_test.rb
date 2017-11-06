require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  it "Can be created" do
    movie.save
    movie.must_be_instance_of Movie
  end
end
