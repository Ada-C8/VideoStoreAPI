require "test_helper"

describe RentalsController do
  let(:averi) { customers(:averi) }
  let(:magic) { movies(:magic) }

  describe "Check Out" do
    it "can check-out a movie" do
      proc {
        post checkout_path params: {customer_id: averi.id, movie_id: magic.id}
      }.must_change "Rental.count", 1

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "customer_id"
      body.must_include "movie_id"
      body.must_include "due_date"

    end

    it "will increase checkout count" do
      start = averi.movies_checked_out_count
      post checkout_path params: {customer_id: averi.id, movie_id: magic.id}
      averi.reload
      averi.movies_checked_out_count.must_equal start + 1

    end

    it "will decrease available inventory" do
      start = magic.available_inventory
      post checkout_path params: {customer_id: averi.id, movie_id: magic.id}
      magic.reload.available_inventory
      magic.available_inventory.must_equal start - 1
    end

    it "won't check-out a movie with bogus customer data" do
      proc {
        post checkout_path params: {customer_id: 0, movie_id: magic.id}
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"

    end

    it "won't check-out a movie with bogus movie data" do
      magic.destroy
      proc {
        post checkout_path params: {customer_id: averi.id, movie_id: movies(:magic).id}
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"

    end

    it "won't create a rental if the available inventory is zero" do
      post checkout_path params:  {customer_id: averi.id, movie_id: movies(:dates).id}

      post checkout_path params:  {customer_id: customers(:gale).id, movie_id: movies(:dates).id}

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"

    end

    it "won't change available inventory or customer checkout count if rental is bogus" do
      start = averi.movies_checked_out_count
      magic.destroy
      post checkout_path params: {customer_id: averi.id, movie_id: movies(:magic).id}
      averi.reload
      averi.movies_checked_out_count.must_equal start
    end

  end

  describe "Check In" do
    it "will check in a movie" do
      post checkin_path params:  {customer_id: averi.id, movie_id: movies(:magic).id}

      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "customer_id"
      body.must_include "movie_id"

    end

    it "won't check in a bad rental request" do

    end

    it "will update the customers checked out count" do

    end

    it "will update the movie's available_inventory" do

    end

    it "won't updated customers or movies if the rental is a bad request" do


    end
  end

  describe "Overdue" do

  end

end
