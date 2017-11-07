require "test_helper"
require 'date'

describe RentalsController do
  # it "should get checkout" do
  #   get rentals_checkout_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get checkin" do
  #   get rentals_checkin_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get overdue" do
  #   get rentals_overdue_url
  #   value(response).must_be :success?
  # end

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

      body =  JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "customer"
      body["errors"].must_include "movie"
    end


  end

  describe "checkin" do

  end

  describe "overdue" do

  end
end
