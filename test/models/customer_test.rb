require "test_helper"

describe Customer do
  let(:customer) { Customer.new(
    "name": "Shelley Rocha",
    "registered_at": "Wed, 29 Apr 2015 07:54:14 -0700",
    "address": "Ap #292-5216 Ipsum Rd.",
    "city": "Hillsboro",
    "state": "OR",
    "postal_code": "24309",
    "phone": "(322) 510-8695",
    "account_credit": 13.15)
  }

  it 'is valid with valid data' do
    customer.must_be :valid?
  end

  it 'is not valid without a name' do
    customer.name.clear

    customer.wont_be :valid?
  end

  describe 'address' do

    it 'is not valid without an address' do
      customer.address.clear

      customer.wont_be :valid?
    end

    it 'is not valid without a city' do
      customer.city.clear

      customer.wont_be :valid?
    end

    it 'is not valid without a state' do
      customer.state.clear

      customer.wont_be :valid?
    end

    it 'is not valid without a postal code' do
      customer.postal_code.clear

      customer.wont_be :valid?
    end
  end

  it 'is not valid without an account balance' do
    customer.account_credit = nil

    customer.wont_be :valid?
  end
end
