require "test_helper"

describe RentalsController do
  let(:movie_one) {movies(:one)}
  let(:customer_one) {customers(:one)}
  def create_rental
    post create_rental_path,
    params: {
      movie_id: movie_one.id,
      customer_id: customer_one.id,
      due_date: "2017-12-15"
    }
  end


  describe "create" do
    it "must respond with JSON" do
      create_rental
      response.header['Content-Type'].must_include 'json'
    end

    it "returns only the required fields" do
      create_rental
      key = ['id']
      body = JSON.parse(response.body)
      body.keys.sort.must_equal key
    end

    it "can create a new rental" do
      proc {create_rental}.must_change "Rental.count", 1
      must_respond_with :ok
      body = JSON.parse(response.body)
      body["id"].must_be_instance_of Integer
    end

    it "cannot check out more movies than inventory allows" do
      movie_one.inventory = 1
      movie_one.save.must_equal true
      create_rental
      must_respond_with :ok
      create_rental
      must_respond_with :bad_request
    end

    it "cannot check out a movie for either an invalid customer id" do
      invalid_customer_id = -1
      post create_rental_path,
      params: {
        movie_id: movie_one.id,
        customer_id: invalid_customer_id,
        due_date: "2017-12-15"
      }
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body["ok"].must_equal false
      body["errors"].must_include "customer"
      body["errors"]["customer"].must_include "must exist"
    end

    it "cannot check out a movie for either an invalid movie id" do
      invalid_movie_id = -1
      post create_rental_path,
      params: {
        movie_id: invalid_movie_id,
        customer_id: customer_one.id,
        due_date: "2017-12-15"
      }
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body["ok"].must_equal false
      body["errors"].must_include "movie"
      body["errors"]["movie"].must_include "must exist"
    end
  end

  describe "update" do
    def update_rental
      post update_rental_path,
      params: {
        movie_id: movie_one.id,
        customer_id: customer_one.id
      }
    end

    before do
      create_rental
    end

    it "must respond with JSON" do
      update_rental
      response.header['Content-Type'].must_include 'json'
    end

    it "returns only the required fields" do
      update_rental
      key = ['id']
      body = JSON.parse(response.body)
      body.keys.sort.must_equal key
    end

    it "can update a rental" do
      rental = Rental.find_by(customer_id: customer_one.id, movie_id: movie_one.id)
      before_return = rental.checkin_date
      before_return.must_equal nil
      update_rental
      rental = Rental.find_by(customer_id: customer_one.id, movie_id: movie_one.id)
      after_rental = rental.checkin_date
      after_rental.must_equal Date.today

      must_respond_with :ok
      body = JSON.parse(response.body)
      body["id"].must_be_instance_of Integer
    end

    it "returns proper errors when the rental is invalid" do
      invalid_customer_id = -1
      post update_rental_path,
      params: {
        movie_id: movie_one.id,
        customer_id: invalid_customer_id
      }
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body["ok"].must_equal false
      body["errors"].must_include "Rental does not exist."
    end
  end
end
