require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  it "must be valid" do
    customers(:one).valid?.must_equal true
  end

  it "must have a name to be valid" do
    customer.valid?.must_equal false
    customer.name = "Name"
    customer.valid?.must_equal true
  end
end
