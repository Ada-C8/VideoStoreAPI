require "test_helper"

describe Movie do
  let(:movie) { movies(:nacho_libre)}

  it "must be valid" do
    value(movie).must_be :valid?
  end

  it "requires a title to be valid" do
    movie.title = nil
    movie.valid?.must_equal false

  end

  it "requires an overview to be valid" do
    movie.overview = nil
    movie.valid?.must_equal false
  end

  it "requires a release date in the proper format to be valid" do
    movie.release_date = nil
    movie.valid?.must_equal false

    movie.release_date = "22-21-29"
    movie.valid?.must_equal false
  end

  it "requires an inventory integer that is equal or greater than 0 to be valid " do
    movie.inventory = nil
    movie.valid?.must_equal false

    movie.inventory = 3.1
    movie.valid?.must_equal false

    movie.inventory = -1
    movie.valid?.must_equal false

    movie.inventory = 0
    movie.valid?.must_equal true
  end

  # it "won't create a movie if a movie with the same title and same release year already exists" do
  #   not_uniq_movie = movie.clone()
  #   not_uniq_movie.valid?.must_equal false
  # end


end
