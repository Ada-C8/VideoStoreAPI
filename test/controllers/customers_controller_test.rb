require "test_helper"

describe CustomersController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  describe 'index' do
    it 'is a real working route' do
      get customers_path
      must_respond_with :success
    end

    it 'returns JSON' do
      get customers_path
      response.header['Content-Type'].must_include 'json'
    end

    it 'returns an array' do
      get customers_path
      body = JSON.parse(response.body)

      body.must_be_kind_of Array
    end

    it 'returns all customers' do
      get customers_path
      body = JSON.parse(response.body)

      body.length.must_equal Customer.count
    end

    it 'returns customers with exactly the required fields' do
      keys = %w(id name registered_at address city state postal_code phone account_credit movies_checked_out_count)
      get customers_path
      body = JSON.parse(response.body)

      body.each do |customer|
        customer.keys.must_equal keys
      end
    end

    it 'returns an empty array if there are no customers' do
      Customer.destroy_all
      get customers_path
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end
  end

  describe "show" do
    it "can get a customer" do
      get customer_path(customers(:one).id)
      must_respond_with :success
    end

    it "returns a hash with all of the fields about a particular customer" do
      get customer_path(customers(:one).id)
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body["address"].must_equal customers("one").address
    end

    it "returns not found when customer does not exist" do
      invalid_customer_id = Customer.all.last.id + 1
      get customer_path(invalid_customer_id)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end
  end

  describe 'create' do
    let (:customer_data) {
      {
        id: 1,
        name: "Jamie",
        registered_at: "yesterday",
        address: "ADA",
        city: "Los Angeles",
        state: "California",
        postal_code: "90210",
        phone: "12345",
        account_credit: 2,
        movies_checked_out_count: 1
      }
    }

    it 'creates a new customer' do
      proc { post customers_path, params: {customer: customer_data}}.must_change 'Customer.count', 1

      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      Customer.find(body["id"]).name.must_equal customer_data[:name]
    end

    it 'returns an error for invalid customer' do
      invalid_customer_data = {
        name: "Dan"
      }

      proc {
        post customers_path, params: {
          customer: invalid_customer_data
        }
      }.wont_change 'Customer.count'

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash

      body.must_equal "errors" => {"phone" => ["can't be blank"]}
    end
  end
end
