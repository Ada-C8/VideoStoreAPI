require "test_helper"

describe Rental do
  let(:rental) { Rental.new }

  it "must be valid with due date" do
    rental.due_date = "2017-11-10"
    rental.valid?.must_equal false

    rental.customer = customers(:averi)
    rental.movie = movies(:magic)
    rental.valid?.must_equal true

    rental.due_date = nil
    rental.valid?.must_equal false
    rental.due_date = "apr 17, 2001"
    rental.valid?.must_equal false
    rental.due_date = "06-15-2017"
    rental.valid?.must_equal false
  end
end
