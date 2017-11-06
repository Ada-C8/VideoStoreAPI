require "test_helper"

describe Rental do
  describe "validations" do
    it "must have a due date" do
      rental = rentals(:one)
      rental.due_date = nil
      rental.valid?.must_equal false
    end
  end
end
