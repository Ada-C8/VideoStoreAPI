require "test_helper"

describe CustomersController do
  describe "index" do

    it "returns successfully returns json as an Array" do
      get customers_path
      must_respond_with :success

      response.header['Content-Type'].must_include 'json'

      body = JSON.parse(response.body)
      body.must_be_instance_of Array
    end

    it 'returns ALL of the customers' do
      get customers_path
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns customers with exactly the fields required" do
      keys = %w(id name registered_at postal_code phone)
      get customers_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys.sort
      end
    end
  end
end
