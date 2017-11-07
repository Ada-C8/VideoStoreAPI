require "test_helper"

describe Customer do
  let(:customer_one) { customers(:customer_one) }
  let(:customer_two) { customers(:customer_two) }

  describe "valid" do

    it "will return false without name" do
      customer_one.name = nil
      customer_one.wont_be :valid?
    end

    it "will return false without registered_at" do
      customer_one.registered_at = nil
      customer_one.wont_be :valid?
    end

    it "will return false without address" do
      customer_one.address = nil
      customer_one.wont_be :valid?
    end

    it "will return false without city" do
      customer_one.city = nil
      customer_one.wont_be :valid?
    end

    it "will return false without state" do
      customer_one.state = nil
      customer_one.wont_be :valid?
    end

    it "will return false without postal code" do
      customer_one.postal_code = nil
      customer_one.wont_be :valid?
    end

    it "will return false without phone" do
      customer_one.phone = nil
      customer_one.wont_be :valid?
    end

  end
end
