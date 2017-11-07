require "test_helper"

describe RentalsController do
  describe "create" do
    let(:create_rental) {
      post create_rental_path,
      params: {
        movie_id: movies(:one).id,
        customer_id: customers(:one).id,
        due_date: "2017-12-15"
      }
    }

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

    # it "cannot save a duplicate movie (same title)" do
    #   proc {post create_movie_path, params: {title: "Raiders of the Lost Ark"}}.must_change "Movie.count", 1
    #   proc {post create_movie_path, params: {title: "Raiders of the Lost Ark"}}.must_change "Movie.count", 0
    #   must_respond_with :bad_request
    #   body = JSON.parse(response.body)
    #   body["ok"].must_equal false
    #   body["errors"].keys.must_include "title"
    #   body["errors"]["title"].must_include "Movie title must be unique."
    # end
  end
end
