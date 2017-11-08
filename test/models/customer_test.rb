require "test_helper"

describe Customer do
  let(:customer_one) { customers(:customer_one)}
  let(:customer) { Customer.new }

  it "must be valid" do
    customer_one.save
    customer_one.valid?.must_equal true
  end

  it "must have a name, registered_at, address, city, state, postal code, and phone number" do
    customer.valid?.must_equal false

    customer.postal_code = "98119"
    customer.valid?.must_equal false

    customer.name = "Namo"
    customer.valid?.must_equal false

    customer.phone = "416173"
    customer.valid?.must_equal false

    customer.registered_at = "Tuesday, 03 Nov 2016 15:39:10 -0900"
    customer.address = "whatever st"
    customer.city = "Radtown"
    customer.state = "WAtever"

    customer.valid?.must_equal true
  end



end
