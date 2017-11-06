require "test_helper"

describe CustomersController do
  describe "index" do
    it "is a real working route" do
      get customers_path
      must_respond_with :success
    end

    it "returns an empty array if there are no Customers" do
      Customer.destroy_all

      get customers_path
    end

    it "returns a json" do
      get customers_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get customers_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the Customers" do
      get customers_path

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns Customers with exactly the required fields" do
      keys = %w(account_credit address city id name phone postal_code registered_at state)
      get customers_path
      body = JSON.parse(response.body)
      body.each do | customer |
        customer.keys.sort.must_equal keys
      end
    end
  end
end
