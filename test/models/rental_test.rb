require "test_helper"

describe Rental do
  let(:rental) {Rental.new}

  describe "VALIDATIONS" do
    it "can be created, and has an id" do
      rental.customer = customers(:shelley)
      rental.movie = movies(:robin_hood)
      rental.checkout_date = "2020-12-20"
      rental.due_date = "2020-12-31"

      proc {
        rental.save
      }.must_change('Rental.count', 1)
      rental.must_respond_to :id
    end

    it "cannot be created without customer, movie, checkout_date, due_date" do
      rental.valid?.must_equal false
      rental.errors.must_include :customer
      rental.errors.must_include :movie
      rental.errors.must_include :checkout_date
      rental.errors.must_include :due_date
    end

  end

end
