require "test_helper"

describe Customer do
  let(:customer) { customers(:bill) }

  describe "validations" do
    it "a customer requires a name" do
      start_count = Customer.count

      invalid_customer = Customer.new
      invalid_customer.save
      invalid_customer.valid?.must_equal false
      invalid_customer.errors.messages.must_include :name

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

  describe "relations" do
    it "has many rentals" do
      customer.must_respond_to :rentals
      customer.must_be_kind_of Customer
      customer.rentals.each do |item|
        item.must_be_kind_of Rental
      end
    end
  end

end
