require "test_helper"

describe CustomersController do
  describe "#index" do
    before do
      get customers_path
    end

    it "is a real route" do
      must_respond_with :success
    end

    it "returns an array" do
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end
    it "returns all the customers" do
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end
    it "returns customers with exactly the required fields" do
      keys = %w(address city movies_checked_out name phone postal_code registered_at state)
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end
    it "returns an empty array is there are no customers" do
      Customer.destroy_all
      get customers_path
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end
  end

end
