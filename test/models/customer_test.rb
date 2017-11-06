require "test_helper"
require "awesome_print"

describe Customer do

  it "a customer object can be saved to the database" do
    customer = Customer.new
    customer.save.must_equal true
  end

  describe "self.index_customers" do
    before do
      @customers = Customer.index_customers
    end
    it "returns an array of hashes" do
      @customers.must_be_instance_of Array
      @customers.length.must_equal Customer.count
      @customers.each do |customer|
        customer.must_be_instance_of Hash
      end
    end

    it "contains appropriate customer information" do
      @customers.each do |customer|
        customer.keys.must_include "id"
        customer.keys.must_include "name"
        customer.keys.must_include "registered_at"
        customer.keys.must_include "postal_code"
        customer.keys.must_include "phone"
        customer.keys.must_include "movies_checked_out_count"
      end
    end
  end

end
