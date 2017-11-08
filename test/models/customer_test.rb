require "test_helper"

describe Customer do
  let(:customer1) { customers(:one) }
  # let(:customer_new) { Customer.new}

  describe "relationships" do
    it "has rentals" do
      # TODO: later on add rentals and show that each customer1.rentals , everything that returns .must_be_kind_of Rental
      customer1.must_respond_to :rentals
    end

    it "can have zero rentals" do
      Rental.destroy_all
      customer1.must_respond_to :rentals
    end

    it "has movies" do
      # TODO: later on add rentals and show that each customer1.movies , everything that returns .must_be_kind_of Movie
      customer1.must_respond_to :movies
    end

    it "can have zero movies" do
      Movie.destroy_all
      customer1.must_respond_to :movies
    end
  end

  describe "validations" do
    it "can be created" do
      before = Customer.count

      new_customer = Customer.new(name: "test", registered_at: "test", postal_code: "11111", phone: "(111) 111-1111", address: "test", city: "test", state: "test")

      new_customer.must_be :valid?
      new_customer.save

      Customer.count.must_equal before + 1
    end

    it "will return false with out a name" do
      customer1.name = nil
      customer1.wont_be :valid?
    end

    it "will return false without a registered_at" do
      customer1.registered_at = nil
      customer1.wont_be :valid?
    end

    it "will return false without a postal_code" do
      customer1.postal_code = nil
      customer1.wont_be :valid?
    end

    it "will return false without a phone number" do
      customer1.phone = nil
      customer1.wont_be :valid?
    end
  end

  describe "custom methods" do
    describe "update_customer_movies" do
      it "will increase movies_checked_out_count by the amount passed in" do
        before = customer1.movies_checked_out_count
        customer1.update_customer_movies(1)
        customer1.movies_checked_out_count.must_equal before + 1
      end
      # TODO: write edge case method for this
    end
  end
end
