require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  it "must be valid" do
    customer.save
    customer.valid?.must_equal true
  end


end
