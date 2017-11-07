require "test_helper"

describe RentalsController do
  let(:averi) { customers(:averi) }
  let(:magic) { movies(:magic) }

  describe "Check Out" do
    it "can check-out a movie" do
      proc {
        post checkout_path params: {rental: {customer_id: averi.id, movie_id: magic.id}}
      }.must_change "Rental.count", 1

      body = JSON.parse(response.body)
      puts body
      body.must_be_kind_of Hash
      body.must_include "customer_id"
      body.must_include "movie_id"
      body.must_include "due_date"

    end

    it "won't check-out a movie with bogus customer data" do
      proc {
        post checkout_path params: {rental: {customer_id: 0, movie_id: magic.id}}
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"

    end

    it "won't check-out a movie with bogus movie data" do
      magic.destroy
      proc {
        post checkout_path params: {rental: {customer_id: averi.id, movie_id: movies(:magic).id}}
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"

    end

  end

  describe "Check In" do

  end

  describe "Overdue" do

  end

end
