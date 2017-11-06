require "test_helper"

describe CustomersController do
  describe "index" do
    it "is a real working route" do
      get customers_path
      must_respond_with :success
    end
    # it "must be a real test" do
    #   flunk "Need real tests"
    # end
  end
end
