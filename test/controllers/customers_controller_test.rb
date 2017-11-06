require "test_helper"

describe CustomersController do
  describe "index" do
    it "is a working route" do
      get customers_path
      must_respond_with :success
    end

    it "returns json" do
      get customers_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array" do
      get customers_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the customers" do
      get customers_path
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns the customers with exactly the required fields" do
      get customers_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal ["account_credit", "address", "city", "id", "name", "phone", "postal_code", "registered_at", "state"]
      end
    end

    it "returns an empty array if there are no customers" do
      Customer.destroy_all
      get customers_path
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end
  end

  describe "show" do
    it "returns a customer" do
      get customer_path(customers(:one).id)
      must_respond_with :success
    end

    it "returns not_found when customer is not found" do
      invalid_customer_id = Customer.last.id + 1
      get customer_path(invalid_customer_id)
      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end
  end
end
