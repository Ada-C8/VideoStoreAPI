require "test_helper"

describe CustomersController do
  describe "#index" do
    it "returns json" do
      get customers_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns only the required fields" do
      keys = %w(id movies_checked_out_count name phone postal_code registered_at)
      get customers_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end

    it "must return an empty array if no customers exist" do
      #avoid foreign key constraint
      Rental.destroy_all
      #test
      Customer.destroy_all
      get customers_path
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_equal []
    end

    it "will return an array of all customers if they exist" do
      get customers_path
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_instance_of Array
      body.length.must_equal Customer.count
    end
  end
end
