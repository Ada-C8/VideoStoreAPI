require "test_helper"

describe CustomersController do
  it "should get index" do
    get customers_path
    value(response).must_be :success?
  end

end
