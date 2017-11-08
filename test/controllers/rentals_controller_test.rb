require "test_helper"

describe RentalsController do
  describe "check-out" do
    let(:rental_data) {
       {customer_id: customers(:shelley).id, movie_id: movies(:robin_hood).id}
     }

    it "creates a new rental" do
      proc{post checkout_path(rental_data)}.must_change('Rental.count', 1)
      must_respond_with :ok
    end

    it "returns json with the id of the rental created" do
      post checkout_path(rental_data)

      body = JSON.parse(response.body)
      rental_id = Rental.last.id

      body["id"].must_equal rental_id
    end

    it "returns an error for an invalid rental" do
      proc{post checkout_path({})}.must_change('Rental.count', 0)

      body = JSON.parse(response.body)
      body["ok"].must_equal false
      must_respond_with :bad_request
    end

  end
end
