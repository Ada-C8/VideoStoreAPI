require "test_helper"

describe Movie do

  it "a movie object can be saved to the database" do
    movie = Movie.new(title: "Title")
    movie.save.must_equal true
  end


end
