require "test_helper"
require "awesome_print"

describe Customer do

  it "a customer object can be saved to the database" do
    customer = Customer.new
    customer.save.must_equal true
  end

end
