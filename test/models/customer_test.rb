require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  it "Can be created" do
    customer.save
    customer.must_be_instance_of Customer
  end
end
