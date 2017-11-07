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

    it "returns all of the pets" do
      get customers_path

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns pets with exactly the required fields" do
      keys = %w(id movies_checked_out_count name phone postal_code registered_at)
      get customers_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end
  end

  describe "test" do
    it "returns json" do
      get test_path
      response.header['Content-Type'].must_include 'json'
    end
  end
end
