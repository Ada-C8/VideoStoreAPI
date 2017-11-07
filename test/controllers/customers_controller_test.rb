require "test_helper"

describe CustomersController do
  describe "index" do
    it "is a real working rout" do
      get customers_path
      must_respond_with :success
    end # working rout

    it "returns json" do
      get customers_path
      response.header['Content-Type'].must_include 'json'
    end # json

    it "returns an array" do
      get customers_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end # is an array

    it "returns all the customers" do
      get customers_path
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end # returns all the customers

    it "returns customers with exactly the required fields" do
      keys = ["address", "city", "id", "name", "phone", "postal_code", "registered_at", "state"]

      get customers_path

      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end # .each     
    end # correct fields

  end # index
end
