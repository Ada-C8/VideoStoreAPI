require "test_helper"

describe CustomersController do
  describe "index" do
    it "is a working route" do
      get customers_path
      must_respond_with :success
    end

    it "returns json" do
      get customers_path
      response.header['Content-Type'].must_include 'json'
    end

    it 'returns an array' do
      get customers_path
      body = JSON.parse(response.body)
      body.must_be_instance_of Array 

    end
  end
end
