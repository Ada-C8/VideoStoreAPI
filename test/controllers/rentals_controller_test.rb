require "test_helper"
describe RentalsController do

  describe "checkout" do

    let(:rental_data) {
      {
        movie_id: Movie.first.id,
        customer_id: Customer.first.id
      }
    }

    it "is a valid route" do
      post checkout_url(rental_data)
      must_respond_with :created
    end

    it 'returns json' do
      post checkout_path(Movie.first.id, Customer.first.id)
      response.header['Content-Type'].must_include 'json'
    end

    it 'returns an hash' do
      post checkout_path(movie_id: Movie.first.id, customer_id: Customer.first.id)
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it 'returns an hash even if no data' do
      post checkout_path(Movie.last.id + 1, Customer.first.id + 1)
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "Exceeded available inventory!"
    end

    it "returns rental with exactly the required fields" do
      keys = %w(id customer_id movie_id due_date checkout_date)
      post checkout_path(Movie.first.id, Customer.first.id)
      body = JSON.parse(response.body)
      body.keys.must_equal keys
    end
  end

  describe 'checkin' do
    let(:rental_data) {
      {
        movie_id: Movie.first.id,
        customer_id: Customer.first.id
      }
    }

    it "is a valid route" do
      post checkout_url(rental_data)
      body = JSON.parse(response.body)
      id = body['id']

      post checkin_path(id)
      must_respond_with :created
    end

    it 'returns json' do
      post checkin_path(rentals(:not_overdue).id)
      response.header['Content-Type'].must_include 'json'
    end

    it 'returns an hash' do
      post checkin_path(rentals(:not_overdue).id)

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it 'returns an hash even if no data' do

      post checkin_path(999)
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
    end

    it "returns rental with exactly the required fields" do
      post checkout_url(rental_data)
      body = JSON.parse(response.body)
      id = body['id']

      keys = ["id", "customer_id", "movie_id", "due_date", "checkout_date"]
      post checkin_path(id)
      body = JSON.parse(response.body)
      body.keys.must_equal keys
    end
  end



  describe "overdue" do

    it "succeeds" do
      get overdue_path
      must_respond_with :success
    end

    it "returns list  of all customers with overdue movies" do

    end

    it "returns empty array if no customers with overdue movies" do

    end

    it "succeeds wether there are any overdue customers" do

    end
  end

end
