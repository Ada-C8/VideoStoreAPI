require "test_helper"

describe Movie do
  let(:one) { movies(:one) }

  it "must be valid" do
    one.valid?.must_equal true
  end

  it "must have all required fields to be valid" do
    new_movie = Movie.new( release_date: "2017-11-09", overview: "blah blah blah", inventory: 8)
    new_movie.valid?.must_equal false

    new_movie = Movie.new( title: "sometitle", overview: "blah blah blah", inventory: 8)
    new_movie.valid?.must_equal false

    new_movie = Movie.new( release_date: "2017-11-09", title: "sometitle", inventory: 8)
    new_movie.valid?.must_equal false

    new_movie = Movie.new( release_date: "2017-11-09", overview: "blah blah blah", title: "sometitle")
    new_movie.valid?.must_equal false
  end
end
