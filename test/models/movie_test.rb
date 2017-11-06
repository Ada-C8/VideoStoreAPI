require "test_helper"

describe Movie do
  let(:movie) { Movie.new }
  let(:jaws) { movies(:jaws) }

  it "must be valid" do
    jaws.valid?.must_equal true
    jaws.title = nil
    jaws.valid?.must_equal false
  end

  it "must have a title" do
    movie.valid?.must_equal false
    movie.title = "A movie"
    movie.valid?.must_equal true
  end
end
