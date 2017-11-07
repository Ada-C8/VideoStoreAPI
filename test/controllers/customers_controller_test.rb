require "test_helper"

describe CustomersController do
  describe "index" do
    it "is a real working route" do
      get customers_path
      must_respond_with :success
    end

    it "returns json" do
      get customers_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get customers_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the customers" do
      get customers_path

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns customers with exactly the required fields" do
      keys = %w(id name phone postal_code registered_at)

      get customers_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
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
    it "is a real working route" do
      first_id = Customer.first.id
      get customer_path(first_id)
      must_respond_with :success
    end

    it "responds correctly when the customer is not found" do
      invalid_id = Customer.last.id + 1
      get customer_path(invalid_id)
      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_equal "id" => "Invalid Customer ID"
    end
  end

  describe "create" do
    it "Can create a new customer" do
      customer_data = {
        name: "name",
        registered_at: "registered at",
        address: "address",
        city: "city",
        state: "state",
        postal_code: "postal code"
      }

      proc{
        post customers_path, params: {customer: customer_data}
      }.must_change 'Customer.count', 1
      must_respond_with :success
    end

    it "won't change db if data is missing" do
      invalid_customer_data = {
        # name: "name",
        # registered_at: "registered at",
        # address: "address",
        # city: "city",
        # state: "state",
        # postal_code: "postal code"
        fake: "fake"
      }
      binding.pry

      proc {
        post customers_path, params: {customer: invalid_customer_data}
      }.wont_change 'Customer.count'

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_equal errors:{"invalid data" => ["Missing needed information"]}
    end
  end


end
