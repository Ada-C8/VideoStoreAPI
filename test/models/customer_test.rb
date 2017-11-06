require "test_helper"

describe Customer do
  let(:customer) { Customer.new }
  let(:popo) {Customer.new(
    name: "Popo",
    postal_code: "V5C 6P2",
    phone: "50650"
    )
  }

  describe "VALIDATIONS" do
    it "Can be created" do
      customer.name = "Name"
      customer.postal_code = "V5C 6P2"
      customer.phone = "50560"
      customer.must_be_instance_of Customer
    end

    it "Cannot be created without a name, registered_at, postal_code, phone" do
      customer.valid?.must_equal false
      customer.errors.must_include :name
      customer.errors.must_include :postal_code
      customer.errors.must_include :phone

      customer.name = "Name"
      customer.postal_code = "V5C 6P2"
      customer.valid?.must_equal false
      customer.phone = "50650"
      customer.valid?.must_equal true
    end

    it "Will be created with an id and a registered_at" do
      popo.save
      her_id = Customer.find_by(name: "Popo").id
      popo.id.must_equal her_id
      popo.registered_at.must_equal popo.created_at
    end
  end #VALIDATIONS
end
