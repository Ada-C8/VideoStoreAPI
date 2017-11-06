require "test_helper"

describe CustomersController do
  describe "index" do
    # Positive test
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

    it "returns all customers" do
      get customers_path

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns all customers with exactly the required fields" do
      keys = %w(name registered_at address city state postal_code phone account_credit)

      get customers_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.must_equal keys
      end
    end
  end #index tests

  describe "show" do
    # This bit is up to you!
    it "can get a customer" do
      get customer_path(customers(:two).id)
      must_respond_with :success
    end

    it "responds correctly when a customer is not found" do
      invalid_customer_id = Customer.last.id + 1
      get customer_path(invalid_customer_id)

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end
    # it "responds correctly when pet is not found" do
    #   invalid_pet_id = Pet.all.last.id + 1
    #   get pet_path(invalid_pet_id)
    #
    #   must_respond_with :not_found
    #
    #   body = JSON.parse(response.body)
    #   body.must_equal "nothing" => true
    # end
  end #show tests


end #all tests
