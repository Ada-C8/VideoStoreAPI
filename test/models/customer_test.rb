require "test_helper"

describe Customer do
  let(:customer) { Customer.new }
  let(:popo) {Customer.new(
    name: "Popo",
    postal_code: "V5C 6P2",
    phone: "50650",
    registered_at: "Mon, 06 Nov 2017 14:32:26 -0800"
    )
  }

  describe "VALIDATIONS" do
    it "Can be created" do
      customer.name = "Name"
      customer.postal_code = "V5C 6P2"
      customer.phone = "50560"
      customer.registered_at = "Mon, 06 Nov 2017 14:32:26 -0800"
      proc{customer.save}.must_change('Customer.count', 1)
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
      customer.registered_at = "Mon, 06 Nov 2017 14:32:26 -0800"
      customer.valid?.must_equal true
    end

    it "Will be created with an id" do
      popo.save
      her_id = Customer.find_by(name: "Popo").id
      popo.id.must_equal her_id
    end
  end #VALIDATIONS
end
