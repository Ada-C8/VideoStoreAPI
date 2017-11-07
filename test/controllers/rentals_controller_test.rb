require "test_helper"

describe RentalsController do
  describe "checkout" do
    let(:rental_data) {
      {
        movie_id: 1,
        customer_id: 1,
        due_date: Date.now + 4.days
      }
    }

    it "creates a checkout" do
      proc {
        post rentals_checkout_path, params: {rental: rental_data}
      }.must_change 'Rental.count', 1

      must_respond_with :success
    end
  end
end
