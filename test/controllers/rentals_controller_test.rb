require "test_helper"

describe RentalsController do
  let(:valid_movie_id) { Movie.first.id }
  let(:valid_customer_id) { Customer.first.id }
  let(:invalid_customer_id) { Customer.last.id + 1 }
  let(:params) {{ movie_id: valid_movie_id, customer_id: valid_customer_id }}
  let(:rental) { rentals(:one) }
  let(:checkin_params) { { movie_id: rental.movie_id, customer_id: rental.customer_id } }

  describe "checkout" do
    it "creates a new rental" do
      proc {
        post checkout_path, params: params
      }.must_change 'Rental.count', 1

      must_respond_with :success
    end
    it "returns a json" do
      post checkout_path, params: params
      response.header['Content-type'].must_include 'json'
    end
    it "returns a hash" do
      post checkout_path, params: params
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end
    it "returns a bad request if rental cannot be created" do
      proc {
        params[:customer_id] = invalid_customer_id
        post checkout_path, params: params
      }.wont_change 'Rental.count'
    end
  end

  describe "checkin" do
    it "changes an existing rental's status to 'returned' " do
      post checkin_path, params: checkin_params

      must_respond_with :success
      rental_id = rental.id

      Rental.find(rental_id).status.must_equal 'returned'
    end
    it "returns a bad request if rental does not exist" do
      checkin_params['customer_id'] = invalid_customer_id
      post checkin_path, params: checkin_params

      must_respond_with :bad_request
    end
    it "returns a bad request if rental is already returned" do
      post checkin_path, params: checkin_params
      post checkin_path, params: checkin_params

      must_respond_with :bad_request
    end
  end

  describe "overdue" do

  end
end
