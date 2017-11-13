require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  it "must have a title" do
    movie.valid?.must_equal false
    movie.title = "woah"
    movie.valid?.must_equal true
  end


end
