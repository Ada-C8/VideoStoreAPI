require "test_helper"

describe RentalsController do
  let(:rental_data) {
    {
      customer_id: customers(:one).id,
      movie_id: movies(:one).id,
      due_date: "2018-12-25"
    }
  }

  let(:bad_rental_data) {
    {
      customer_id: 100,
      movie_id: 100,
      due_date: "lol"
    }
  }

  let(:no_inventory_rental) {
    {
      customer_id: customers(:one).id,
      movie_id: movies(:no_inventory_movie).id,
      due_date: "2018-12-25"
    }
  }
  describe "checkout" do
    it "is a real working route" do
      post rentals_check_out_path, params: {key: "value"}
      must_respond_with :bad_request
    end

    it "returns json" do
      post rentals_check_out_path, params: rental_data
      response.header['Content-Type'].must_include 'json'
    end

    it "responds with success for a valid data" do
      post rentals_check_out_path, params: rental_data
      must_respond_with :success
    end

    it "creates a new rental when given valid data" do
      proc {
        post rentals_check_out_path, params: rental_data
      }.must_change 'Rental.count', 1
    end


    it "returns a hash" do
      post rentals_check_out_path, params: rental_data
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "returns bad_request for invalid requests" do
      post rentals_check_out_path, params: bad_rental_data
      must_respond_with :bad_request
    end

    it "doesn't create a new rental when given invalid data" do
      proc {
        post rentals_check_out_path, params: bad_rental_data
      }.must_change 'Rental.count', 0
    end

    it "returns bad_request if movie doesn't have inventory" do
      post rentals_check_out_path, params: no_inventory_rental
      must_respond_with :bad_request
    end

    it "returns a rental with exactly the correct required fields" do
      keys = %w(check_out_date customer_id due_date id movie_id)
      post rentals_check_out_path, params: rental_data
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
      body.must_be_instance_of Hash
      body.count.must_equal 5
    end
  end

  describe "checkin" do
    let(:check_in_data) {
      {
        customer_id: customers(:one).id,
        movie_id: movies(:one).id,
      }
    }

    let(:bad_check_in_data) {
      {
        customer_id: 100,
        movie_id: 100,
      }
    }

    it "it a real working route" do
      post rentals_check_in_path, params: {key: "value"}
      must_respond_with :bad_request
    end

    it "returns json" do
      post rentals_check_in_path, params: rental_data
      response.header['Content-Type'].must_include 'json'
    end

    it "responds with success for a valid data" do
      post rentals_check_in_path, params: check_in_data
      must_respond_with :success
    end

    it "returns a bad request for invalid data" do
      post rentals_check_in_path, params: bad_check_in_data
      must_respond_with :bad_request
    end

    it "modifies a rental when given valid data" do
      post rentals_check_in_path, params: check_in_data
      must_respond_with :success
      rental = rentals(:one)
      rental.check_in.must_equal true
    end

    it "returns a hash" do
      post rentals_check_in_path, params: check_in_data
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "returns bad request if rental doesn't exist" do
      post rentals_check_in_path, params: {customer_id: 100, movie_id: 100}
      must_respond_with :bad_request
    end

    it "returns a rental with exactly the required fields" do
      keys = %w(check_in check_out_date customer_id due_date id movie_id)
      post rentals_check_in_path, params: check_in_data
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
      body.must_be_instance_of Hash
      body.count.must_equal 6
    end

  end

end
