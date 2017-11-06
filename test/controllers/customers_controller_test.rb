require "test_helper"

describe CustomersController do
  describe "#index" do
    it "returns json" do
      get customers_path
      response.header['Content-Type'].must_include 'json'
    end

    it "must return an empty arry if no customers exist" do
      Customer.destroy_all
      get customer_path
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_equal []
    end

    it "will return an array of all customers if they exist" do
      get customer_path
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_instance_of Array
      body.length.must_equal Customer.count
    end
  end
end
