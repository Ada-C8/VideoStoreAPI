require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  it "must be valid" do
    value(customer).must_be :valid?
  end

  describe "relationships" do

  end
  
  describe "validations" do
  end
end
