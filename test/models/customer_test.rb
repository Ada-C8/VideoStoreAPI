require "test_helper"

describe Customer do
  it "a customer requires a name" do
    start_count = Customer.count

    customer = Customer.new
    customer.save
    customer.valid?.must_equal false
    customer.errors.messages.must_include :name

    Customer.count.must_equal start_count
  end

  it "a customer is created with a name" do
    start_count = Customer.count

    customer1 = Customer.new(name: "Professor X")
    customer1.save
    customer1.valid?.must_equal true

    Customer.count.must_equal start_count + 1
  end

end
