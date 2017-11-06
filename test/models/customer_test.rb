require "test_helper"

describe Customer do
  describe "validations" do
    let(:harry) { customers(:harry) }
    let(:sally) { customers(:sally) }

    it "must have a name" do
      harry.name = nil
      harry.valid?.must_equal false
    end

    it "must have a phone num" do
      sally.phone = nil
      sally.valid?.must_equal false
    end
  end
end
