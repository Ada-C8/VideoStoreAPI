require "test_helper"

describe Rental do
  let(:rental_one) { rentals(:rental_one) }
  let(:rental) { Rental.new }

  it "exists" do
    rental_one.valid?.must_equal true
  end

  it "must have a due date, customer and movie id" do
    rental.valid?.must_equal false
    rental.due_date = "due date"
    rental.valid?.must_equal false
    rental.customer_id = customers(:customer_one).id
    rental.valid?.must_equal false
    rental.movie_id = movies(:movie_one).id
    rental.valid?.must_equal true
  end

end
