require "test_helper"

describe Customer do
  let(:one) { customers(:one) }

  it "must be valid with all fields present" do
    one.valid?.must_equal true
  end

  it "is invalid with missing name" do
    one.name = nil
    one.valid?.must_equal false
  end
end
