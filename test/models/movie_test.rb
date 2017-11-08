require "test_helper"

describe Movie do

  it "a movie object can be saved to the database" do
    movie = Movie.new(title: "Title")
    movie.save.must_equal true
  end

  it "can return the available inventory for a given movie" do
    movies(:one).available_inventory.must_equal 4

  end

end
