require "test_helper"

describe Customer do
  let(:invalid) { Customer.new }
  let(:one) {customers(:one)}
  let(:two) {customers(:two)}

  # :name, :registered_at, :address, :city, :state, :postal_code, :phone, account_credit
  it "must have all attributes to be valid" do
    Customer.all.each do |customer|
      customer.valid?.must_equal true
    end
  end

  it "must have a name to be valid" do
    one.name = nil
    one.valid?.must_equal false
  end

  it "must have a registered_at to be valid" do
    one.registered_at = nil
    one.valid?.must_equal false
  end

  it "must have a address to be valid" do
    one.address = nil
    one.valid?.must_equal false
  end

  it "must have a city to be valid" do
    one.city = nil
    one.valid?.must_equal false
  end

  it "must have a state to be valid" do
    one.state = nil
    one.valid?.must_equal false
  end

  it "must have a postal_code to be valid" do
    one.postal_code = nil
    one.valid?.must_equal false
  end

  it "must have a phone to be valid" do
    one.phone = nil
    one.valid?.must_equal false
  end

  it "must have an account_credit to be valid" do
    one.account_credit = nil
    one.valid?.must_equal false
  end

  it "account_credit must be a decimal to be valid" do
    two.account_credit = "not a decimal"
    two.valid?.must_equal false

    two.account_credit = 1
    two.valid?.must_equal true

    two.account_credit = 1.5
    two.valid?.must_equal true
  end

  it "account_credit must be greater than or equal to 0" do
    two.account_credit = -1.0
    two.valid?.must_equal false

    two.account_credit = 0
    two.valid?.must_equal true
  end

end
