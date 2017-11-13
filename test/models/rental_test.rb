require "test_helper"

describe Rental do
  let(:rental) { Rental.new }

  it "is invalid without a customer and movie" do
    rental.valid?.must_equal false
    rental.customer_id.must_equal nil
    rental.movie_id.must_equal nil
    rental.errors.keys.must_include :customer && :movie
  end

  it "is invalid without a due_date" do
    rental = rentals(:no_due_date)
    rental.valid?.must_equal false
  end

  it "is invalid without a check_out_date" do
    rental = rentals(:no_check_out_date)
    rental.valid?.must_equal false
  end

  it "is invalid if movie has no available inventory" do
    rental = rentals(:no_inventory_rental)
    rental.valid?.must_equal false
  end
end
