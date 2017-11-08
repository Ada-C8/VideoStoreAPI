require "test_helper"

describe Customer do
  let(:customer) { Customer.new(
    "name": "Shelley Rocha",
    "registered_at": "Wed, 29 Apr 2015 07:54:14 -0700",
    "address": "Ap #292-5216 Ipsum Rd.",
    "city": "Hillsboro",
    "state": "OR",
    "postal_code": "24309",
    "phone": "(322) 510-8695")
  }

  describe 'validations' do

    it 'is valid with valid data' do
      customer.must_be :valid?
    end

    it 'validates presence of name' do
      customer.name = nil

      customer.wont_be :valid?
      customer.errors.must_include :name
    end

    describe 'address' do
      it 'validates presence of address' do
        customer.address = nil

        customer.wont_be :valid?
        customer.errors.must_include :address
      end

      it 'validates presence of city' do
        customer.city = nil

        customer.wont_be :valid?
        customer.errors.must_include :city
      end

      it 'validates presence of state' do
        customer.state = nil

        customer.wont_be :valid?
        customer.errors.must_include :state
      end

      it 'validates presence of postal code' do
        customer.postal_code = nil

        customer.wont_be :valid?
        customer.errors.must_include :postal_code
      end
    end

    it 'validates presence of account balance' do
      customer.account_credit = nil

      customer.wont_be :valid?
      customer.errors.must_include :account_credit
    end

    it 'validates numericality of account balance' do
      customer.account_credit = "dog"

      customer.wont_be :valid?
      customer.errors.must_include :account_credit
    end

    it 'defaults account credit to 0' do
      customer.account_credit.must_equal 0.0
    end

    it 'can have phone number' do
      customer.must_respond_to :phone
    end

    it 'has movies_checked_out_count' do
      customer.must_respond_to :movies_checked_out_count
    end

    it 'defaults movies_checked_out_count to 0' do
      customer.movies_checked_out_count.must_equal 0
    end
  end
end
