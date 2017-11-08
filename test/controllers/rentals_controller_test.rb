require "test_helper"

describe RentalsController do

  describe "checkout" do
    let(:rental_data) {
      {
        customer_id: customers(:one).id,
        movie_id: movies(:one).id,
        due_date: "3 Nov 2018",
        checkout_date: "10 Sept, 2017"
      }
    }
    it "creates a rental" do
      proc{
        post checkout_path, params: {rental: rental_data}
      }.must_change 'Rental.count', 1

      must_respond_with :success
    end

    it "won't change the db if data is missing" do
      invalid_rental_data = {
        customer_id: customers(:one).id,
        due_date: "3 Nov 2018",
        checkout_date: "10 Sept, 2017"
      }
      proc{
        post checkout_path, params: {rental: invalid_rental_data}
      }.wont_change 'Rental.count', 1
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_equal "errors" =>{"movie"=>["must exist", "can't be blank"]}
    end

  end

  describe "checkin" do
    it "changes due date to nil with correct information and responds with success" do
      post checkin_path(rentals(:one).id)
      must_respond_with :success
      body.must_include "customer_id"
      body.must_include "movie_id"
    end

    it "responds with not_found if rental doesn't exist" do
      post checkin_path(1)
      must_respond_with :not_found
    end
  end

end
