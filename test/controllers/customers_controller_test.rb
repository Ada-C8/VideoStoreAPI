require "test_helper"

describe CustomersController do

  describe 'index' do
    it 'is a working route' do
      get customers_url
      must_respond_with :success
    end

    it 'returns json' do
      get customers_url
      response.header['Content-Type'].must_include 'json'
    end

    it 'returns an array' do
      get customers_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it 'returns an array even if no data' do
      Customer.destroy_all

      get customers_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.count.must_equal 0
      body.must_equal []

    end

    it "returns customers with exactly the required fields" do
      keys = %w(id name registered_at address city state postal_code phone account_credit)
      get customers_url
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.must_equal keys
      end
    end

  end

  describe 'show' do

    it 'can get a customer' do
      get customer_path(customers(:two).id)
      must_respond_with :success
    end

    it 'returns error for invalid customer' do
      customers(:two).destroy
      get customer_path(customers(:two).id)
      must_respond_with :not_found
    end

  end

end
