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

  describe 'validations' do

    it 'is valid with valid data' do
      customer.must_be :valid?
    end

    it 'validates presence of name' do
      customer.name = nil

      customer.wont_be :valid?
    end

    describe 'address' do
      it 'validates presence of address' do
        customer.address = nil

        customer.wont_be :valid?
      end

      it 'validates presence of city' do
        customer.city = nil

        customer.wont_be :valid?
      end

      it 'validates presence of state' do
        customer.state = nil

        customer.wont_be :valid?
      end

      it 'validates presence of postal code' do
        customer.postal_code = nil

        customer.wont_be :valid?
      end
    end

    it 'validates presence of account balance' do
      customer.account_credit = nil

      customer.wont_be :valid?
    end

    it 'validates numericality of account balance' do
      customer.account_credit = "dog"

      customer.wont_be :valid?
    end
  end
end
