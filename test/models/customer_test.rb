require "test_helper"

describe Customer do
  let (:customer) { customers(:one) }
  describe "relationships" do

    it "has many rentals" do
      customer.must_respond_to :rentals
    end

    it "has many movies" do
      customer.must_respond_to :movies
    end
  end
  # order.order_products.each do |op|
  #   op.product.must_be_kind_of Product
  # end

  describe "validations" do
    it "has a name" do
      customer.must_respond_to :name
    end

    it "has a phone" do
      customer.must_respond_to :phone
    end

  end


  describe "methods" do
    it "adds to checkout count" do
      customer = customers(:one)
      count = customer.movies_checked_out_count
      customer.add_checkout_count
      customer.movies_checked_out_count.must_equal count + 1
    end

    it "decreases checkout count" do
      customer = customers(:one)
      count = customer.movies_checked_out_count
      customer.decrease_checkout_count
      customer.movies_checked_out_count.must_equal count - 1
    end
  end
end
