require "test_helper"

describe Customer do
  let(:customer_one) { customers(:customer_one) }
  let(:customer_two) { customers(:customer_two) }

  describe "valid" do

    it "will return false without name" do
      customer_one.name = nil
      customer_one.wont_be :valid?
    end

    it "will return false without registered_at" do
      customer_one.registered_at = nil
      customer_one.wont_be :valid?
    end

    it "will return false without address" do
      customer_one.address = nil
      customer_one.wont_be :valid?
    end

    it "will return false without city" do
      customer_one.city = nil
      customer_one.wont_be :valid?
    end

    it "will return false without state" do
      customer_one.state = nil
      customer_one.wont_be :valid?
    end

    it "will return false without postal code" do
      customer_one.postal_code = nil
      customer_one.wont_be :valid?
    end

    it "will return false without phone" do
      customer_one.phone = nil
      customer_one.wont_be :valid?
    end

  end

  describe "relationships" do
    before do
      @customer = customers(:customer_one)
    end

    describe "relationship between customers and movies" do

      it "customer responds to movies" do
        @customer.must_respond_to :movies
      end

      it "lists movies for a given customer"  do
        @customer.movies.each do |movie|
          movie.must_be_kind_of Movie
        end
      end
    end

    describe "relationship between customers and rentals" do
      it "responds to rentals" do
        @customer.must_respond_to :rentals
      end

      it "lists rentals for a given customer"  do
        @customer.rentals.each do |rental|
          rental.must_be_kind_of Rental
        end
      end
    end
  end
end
