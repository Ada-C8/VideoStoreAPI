require "test_helper"

describe Movie do
  let(:movie_one) { movies(:movie_one)}
  let(:movie) {Movie.new}

  it "must be valid" do
    movie_one.save
    movie_one.valid?.must_equal true
  end

  it "must have a title, overview, and release date to be valid" do
    movie.valid?.must_equal false
    movie.title = "Men in Black"
    movie.valid?.must_equal false
    movie.overview = "Agents try to stop aliens"
    movie.valid?.must_equal false
    movie.release_date = "Mother's Day"
    movie.valid?.must_equal true
  end

end
