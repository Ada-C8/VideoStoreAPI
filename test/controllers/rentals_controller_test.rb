require "test_helper"

describe RentalsController do
  describe "checkout" do
    let(:rental_data) {
      {
        movie_id: Movie.first.id,
        customer_id: Customer.first.id,
        due_date: Date.today + 4.days
      }
    }

    it "creates a checkout" do
      puts "Starting Create"

      puts rental_data

      proc {
        post rentals_checkout_path, params: {rental: rental_data}
      }.must_change 'Rental.count', 1

      must_respond_with :success
    end
  end
end
