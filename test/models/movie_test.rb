require "test_helper"

describe Movie do
  let (:movie) {Movie.new}
  let (:one) {movies(:one)}
  let (:two) {movies(:two)}

  it "must have a title to be vaild" do
    one.valid?.must_equal true
    one.title = nil
    one.valid?.must_equal false
  end

  it "must have a overview to be vaild" do
    one.valid?.must_equal true
    one.overview = nil
    one.valid?.must_equal false
  end

  it "must have a release date to be vaild" do
    one.valid?.must_equal true
    one.release_date = nil
    one.valid?.must_equal false
  end

  it "must have a release date with a valid date in YYYY-MM-DD format" do
    one.valid?.must_equal true
    one.release_date = "cow"
    one.valid?.must_equal false
    one.release_date = "2017-02-50"
    one.valid?.must_equal false
  end

  it "must have an inventory to be vaild" do
    one.valid?.must_equal true
    one.inventory = nil
    one.valid?.must_equal false
  end

  it "must have an integer in inventory to be vaild" do
    one.valid?.must_equal true
    one.inventory = "zero"
    one.valid?.must_equal false
  end

  it "inventory must be greater than or equal to zero to be vaild" do
    one.valid?.must_equal true
    one.inventory = -1
    one.valid?.must_equal false
  end

  describe "available_inventory" do
    let(:movie){movies(:two)}
    let(:customer1){customers(:one)}
    let(:customer2){customers(:two)}
    it "decreases a movie's available inventory with a new rental" do
      starting_inventory = movie.available_inventory
      Rental.create(customer: customer1, movie: movie)
      Rental.create(customer: customer2, movie: movie)
      movie.available_inventory.must_equal starting_inventory - 2
    end
  end
end
