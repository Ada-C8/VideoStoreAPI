require "test_helper"

describe Customer do
  let(:averi) { customers(:averi) }

  it "must be valid with name, registered_at, postal_code and phone" do
    averi.valid?.must_equal true
  end

  it "is invalid with missing field" do
    averi.name = nil
    averi.valid?.must_equal false
    averi.name = "Averi"

    averi.registered_at = nil
    averi.valid?.must_equal false
    averi.registered_at = "some date"

    averi.postal_code = nil
    averi.valid?.must_equal false
    averi.postal_code = "98001"

    averi.phone = nil
    averi.valid?.must_equal false

  end
end
