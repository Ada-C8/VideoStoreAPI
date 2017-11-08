require "test_helper"

describe Movie do
  let (:movie) { movies(:one) }
  describe "relationships" do

    it "has many rentals" do
      movie.must_respond_to :rentals
    end

    it "has many customers" do
      movie.must_respond_to :customers
    end
  end
  # order.order_products.each do |op|
  #   op.product.must_be_kind_of Product
  # end

  describe "validations" do
    it "has a title" do
      movie.must_respond_to :title
    end

    it "has an inventory" do
      movie.must_respond_to :inventory
    end

  end

  describe "methods" do
    it "checks inventory" do
      movie = movies(:one)
      movie.check_inventory.must_equal true
    end

    it "doesn't check inventory if a movie doesn't exist" do
      movie = movies(:three)
      movie.check_inventory.must_equal false
    end

    it "decreases inventory" do
      movie = movies(:one)
      inventory_count = movie.available_inventory
      movie.decrease_inventory
      movie.available_inventory.must_equal inventory_count - 1
    end

    it "checks if checked out" do
      movie = movies(:four)
      movie.check_if_checked_out.must_equal true
    end

    it "increases inventory" do
      movie = movies(:one)
      inventory_count = movie.available_inventory
      movie.increase_inventory
      movie.available_inventory.must_equal inventory_count + 1
    end
  end
end
