require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  it "must have a name" do
    customer.valid?.must_equal false
    customer.name = "Kayla"
    customer.valid?.must_equal true
  end

  it "must have an account_credit" do
    customer.account_credit.must_equal 0
    customer.account_credit = nil
    customer.valid?.must_equal false
  end
end



#check we are returning same data type like array
