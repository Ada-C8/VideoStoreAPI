require "test_helper"
require 'awesome_print'

describe RentalsController do
  describe "checkout" do
    it "must create a rental record" do
      proc {
        post checkout_path, params: {movie: movies(:dune).id, customer: customers(:harry).id}
      }.must_change 'Rental.count', 1
    end

    it "must set a due_date 5 days in the future" do
      post checkout_path, params: {movie: movies(:gremlins).id, customer: customers(:sally).id}
      rental = Rental.last

      rental.due_date.must_equal Date.today + 5
    end

    it "must decrement the available_inventory for the movie" do
      movie = movies(:gremlins)
      start_inventory = movie.available_inventory
      post checkout_path params: {movie: movie.id, customer: customers(:harry).id}
      movie.available_inventory.must_equal start_inventory - 1
    end

    it "will not create a rental record and will return an error message if the available_inventory is 0" do
      movie = movies(:dune)

      movie.inventory = 1
      movie.save

      post checkout_path params: {movie: movie.id, customer: customers(:sally).id}

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "inventory"
    end

    it "will respond with not found if trying to rent a movie that doesn't exist" do
      movie = movies(:gremlins)
      movie.destroy

      post checkout_path params: { movie: movie.id, customer: customers(:sally).id }

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "id"
    end

    it "will respond with not found if trying to rent a movie for a customer that doesn't exist" do

      sally = customers(:sally)
      sally.destroy

      post checkout_path params: { movie: movies(:gremlins).id, customer: sally.id }

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "id"
    end
  end

  describe "checkin" do
    it "must change the value of returned field to true" do
      rental = rentals(:one)
      rental.returned.must_equal false
      put checkin_path(rental.id)
      rental.reload.returned.must_equal true
    end

    it "must increment the available_inventory of the movie" do
      movie = movies(:gremlins)
      start_inventory = movie.available_inventory
      put checkin_path(rentals(:two).id)
      movie.available_inventory.must_equal start_inventory + 1
    end

    it "must return an error message when attempting to update a returned rental" do
      rental = rentals(:returned)
      put checkin_path(rental.id)
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
    end

    it "must return an error message if given invalid rental id" do
      rental = rentals(:one)
      rental.destroy

      put checkin_path(rental.id)
      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "id"
    end
  end

  describe "overdue" do
    it "returns the list of overdue movies" do
      get rentals_path

      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns empty array if there are no overdue movies" do
      Rental.destroy_all

      get rentals_path

      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end

  end
end
