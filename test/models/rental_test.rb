require "test_helper"

describe Rental do
  let(:rental_one) { rentals(:rental_one) }
  let(:rental_new) { Rental.new }

  it "exists" do
    rental_one.valid?.must_equal true
  end
  it "must have a due date, customer and movie id" do
    rental_new.valid?.must_equal false
    rental_new.due_date = "due date"
    rental_new.valid?.must_equal false
    rental_new.customer_id = customers(:customer_one)
    rental_new.valid?.must_equal false
    rental_new.movie_id = movies(:movie_one)
    rental_new.valid?.must_equal false
    rental_new.save
    puts rental_new
    # rental_new.valid?.must_equal true
  end
end
