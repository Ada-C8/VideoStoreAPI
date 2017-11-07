require "test_helper"

describe Customer do
  let(:customer) { customers(:one) }

  describe "relations" do
    it "a customer can have many movies" do
      customer.must_respond_to :movies
      # customer.movies.each do |movie|
      #   movie.must_be_kind_of Movie
      # end
    end
  end

  describe "validations" do
    it "allows a customer to be created with all required data" do
      customer_data = { name: "New Customer",
      registered_at: "Date",
      address: "Address",
      city: "City",
      state: "State",
      postal_code: "Zip",
      phone: "Phone number",
      account_credit: "Money" }
      customer = Customer.new(customer_data)

      customer.must_be :valid?
    end

    it "requires all the data to be created" do
      invalid_customer_data = { name: "New Customer",
      registered_at: "Date" }
      customer = Customer.new(invalid_customer_data)

      customer.wont_be :valid?
    end
  end
end
