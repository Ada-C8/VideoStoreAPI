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

    # Failure classes
    it "does not return success if bogus data is used" do
      invalid_rental_data = {
          movie_id: Movie.last.id + 1,
          customer_id: Customer.first.id,
          due_date: Date.today + 4.days
        }

      proc {
        post rentals_checkout_path, params: {rental: invalid_rental_data}
      }.wont_change 'Rental.count'

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_equal "errors" => {"movie" => ["must exist"]}
    end
  end
end
