require "test_helper"

describe Rental do
  describe "set_checkout" do
    # HOW DO WE TEST THE NEGATIVE OF THIS?
    it "sets the checkout date for the rental to today" do
      rental = Rental.new
      rental.set_checkout
      rental.checkout_date.must_equal Date.today.strftime( "%Y-%m-%d")
    end

    it "sets due_date for the rental" do
      rental = Rental.new
      rental.set_checkout
      rental.due_date.must_equal (Date.today + 3).strftime( "%Y-%m-%d")
    end
  end #set_checkout

  describe "set_check_in" do
    it "sets the check in date for the rental to today" do
      rental = Rental.new
      rental.set_check_in
      rental.check_in.must_equal Date.today.strftime( "%Y-%m-%d")
    end
  end #set_checkout
end
