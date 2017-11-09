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

  describe "find_rental" do
    it "returns the oldest rental match provided customer and movie" do
      rental1 = rentals(:rental1)
      rental2 = Rental.new(customer: customers(:shelley), movie: movies(:psycho))

      Rental.find_rental({customer_id: customers(:shelley).id, movie_id: movies(:psycho).id}).must_equal rental1
    end

    it "returns nil if no rental is found or bad data" do
      Rental.find_rental({customer_id: customers(:shelley).id, movie_id: movies(:robin_hood).id}).must_be_nil

      Rental.find_rental().must_be_nil
    end

  end
end
