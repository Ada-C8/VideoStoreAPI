require "test_helper"

describe Rental do
  describe "validations" do
    it "can be created when all fields are given" do
      cus_id = Customer.first.id
      mov_id = Movie.first.id
      r = Rental.new(customer_id: cus_id, movie_id: mov_id, due_date: Date.new(2017, 12, 1))

      r.must_be :valid?
    end # can be created

    it "can't be created without a customer_id, movie_id, or due_date" do
      start_count = Rental.count
      r = Rental.new()

      r.wont_be :valid?
      r.errors.messages.must_include :customer_id
      r.errors.messages.must_include :movie_id
      r.errors.messages.must_include :due_date

      r.save
      Rental.count.must_equal start_count
    end
  end # validations
end # Rental
