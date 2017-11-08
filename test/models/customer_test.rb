require "test_helper"

describe Customer do
  let(:customer) { Customer.new() }

  describe 'validations' do
    it "must be valid with a name" do
      customer.name = "Bruce Wayne"
      is_valid = customer.valid?
      is_valid.must_equal true
    end

    it "will not be valid without a name" do
      is_valid = customer.valid?
      is_valid.must_equal false
    end
  end

  describe 'relations' do
    it 'has an association with Rentals' do
      Customer.reflect_on_association(:rental)
    end

    it 'responds to Rentals' do
      customer.must_respond_to :rentals
    end
  end
end
