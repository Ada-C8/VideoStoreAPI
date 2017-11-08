require "test_helper"
require 'date'

describe RentalsController do

  let(:movie) { movies(:movie1) }
  let(:customer) { customers(:bill) }

  describe "checkout" do
    let(:rental_data) {
      {
        movie_id: movie.id,
        customer_id: customer.id,
        due_date: "2017-12-24"
      }
    }

    let(:bad_rental_data) {
      {
        movie_id: -2,
        customer_id: -2,
        due_date: "2017-12-24"
      }
    }

    it "can successfully checkout" do
      assert_difference "Rental.count", 1 do
        post rental_checkout_path, params: rental_data
        assert_response :success
      end

      body =  JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "due_date"
      # p body
      body["checkout_date"].must_equal (Date.today).strftime('%Y-%m-%d')

      Rental.find(body["id"]).customer_id.must_equal rental_data[:customer_id]
    end

    it "returns an error for an invalid rental" do
      post rental_checkout_path, params: bad_rental_data
      assert_response :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "ok"
      body["ok"].must_equal false
    end


  end

  describe "checkin" do
    let(:rental_data) {
      {
        movie_id: movie.id,
        customer_id: customer.id,
        due_date: "2017-12-24"
      }
    }
# let(:rental1) {rentals(:rental1)}
    it "can successfully checkin" do
      post rental_checkout_path, params: rental_data
      post rental_checkin_path(Rental.last.id)
      assert_response :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "checkin_date"
      body["checkin_date"].must_equal (Date.today).strftime('%Y-%m-%d')

      Rental.find(body["id"]).customer_id.must_equal rental_data[:customer_id]
    end

    it "returns not found if movie does not have checkout date" do
      post rental_checkout_path, params: rental_data
      rental = Rental.last
      rental.checkout_date = nil
      rental.save
      post rental_checkin_path(rental.id)

      assert_response :not_found
      body =  JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

  end

  describe "overdue" do

  end
end
