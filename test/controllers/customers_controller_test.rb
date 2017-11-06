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
  end
end
