require "test_helper"

describe Rental do
  let(:rental) { Rental.new }

  describe "validations" do
    it "must be instantiated with a customer and movie" do

      good_rental_data = {
        rental: {
          customer: customers(:one),
          movie: movies(:one)
        }
      }
      first_count = Rental.count
      good_rental = Rental.new(good_rental_data[:rental])
      good_rental.must_be :valid?
      good_rental.save
      final_count = Rental.count
      final_count.must_equal first_count + 1
    end

    it "will not be instantiated with a customer" do
      bogus_info = {
        rental: {
          movie: movies(:one)
        }
      }
      first_count = Rental.count
      good_rental = Rental.new(bogus_info[:rental])
      good_rental.wont_be :valid?
      good_rental.errors.messages.must_include :customer
      good_rental.save
      final_count = Rental.count
      final_count.must_equal first_count
    end

    it  "will not must be instantiated with a  movie" do
      bogus_info = {
        rental: {
          customer: customers(:one)
        }
      }
      first_count = Rental.count
      good_rental = Rental.new(bogus_info[:rental])
      good_rental.wont_be :valid?
      good_rental.errors.messages.must_include :movie
      good_rental.save
      final_count = Rental.count
      final_count.must_equal first_count
    end
  end

  describe "relationships" do
    it "must respond to customer" do
      rental = Rental.first
      rental.must_respond_to :customer
    end

    it "must respond to movie" do
      rental = Rental.first
      rental.must_respond_to :movie
    end
  end
end
