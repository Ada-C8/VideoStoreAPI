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
end
