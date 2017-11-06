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
      body.length.must_equal Customer.count
    end


  end
end
