require "test_helper"

describe CustomersController do
  describe "index" do
    it "it is a working route" do
      get customers_path
      must_respond_with :success
    end
    it "it returns a json" do
      get customers_path
      response.header['Content-type'].must_include 'json'
    end
    it "it returns an array" do
      get customers_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end
    it "it returns all of the customers" do
      get customers_path
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end
    it "it returns customers with the exact required fields" do
      keys = %w(account_credit address city id name phone postal_code registered_at state).sort
      get customers_path
      body = JSON.parse(response.body)

      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end
    it "it returns an empty array if no customers with status 200" do
      Customer.destroy_all

      get customers_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array

      body.must_be :empty?
    end
  end
end
