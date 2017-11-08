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
      #####FILL IN###########
    end
    it "decreases inventory" do
      #####FILL IN###########
    end
  end
end
