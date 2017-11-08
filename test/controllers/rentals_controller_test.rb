require "test_helper"

describe RentalsController do
  describe "checkout" do
    let(:customer_one) { customers :customer_one}
    let(:movie_one) { movies :movie_one}

    it "is a working route" do
      valid_rental_info = {
        rental: {
          customer_id: customer_one.id,
          movie_id: movie_one.id,
          due_date: "2019-11-14",
          checkout_date: "2019-11-07",
        }
      }

      post checkout_path(params: valid_rental_info)
      must_respond_with :success
    end

    it "return json" do
      valid_rental_info = {
        rental: {
          customer_id: customer_one.id,
          movie_id: movie_one.id,
          due_date: "2019-11-14",
          checkout_date: "2019-11-07",
        }
      }
      post checkout_path(params: valid_rental_info)
      response.header['Content-Type'].must_include 'json'
    end

    it "returns a hash" do
      valid_rental_info = {
        rental: {
          customer_id: customer_one.id,
          movie_id: movie_one.id,
          due_date: "2019-11-14",
          checkout_date: "2019-11-07",
        }
      }
      post checkout_path(params: valid_rental_info)

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "increases the number of rentals in db" do
      rental_count = Rental.count

      valid_rental_info = {
        rental: {
          customer_id: customer_one.id,
          movie_id: movie_one.id,
          due_date: "2019-11-14",
          checkout_date: "2019-11-07",
        }
      }
      post checkout_path(params: valid_rental_info)

      Rental.count.must_equal (rental_count + 1)
    end

    it "returns rental id" do
      valid_rental_info = {
        rental: {
          customer_id: customer_one.id,
          movie_id: movie_one.id,
          due_date: "2019-11-14",
          checkout_date: "2019-11-07",
        }
      }
      post checkout_path(params: valid_rental_info)

      body = JSON.parse(response.body)
      body.must_include "id"

    end
  end

  it "returns an error message if not enough inventory" do
    movie = Movie.create(title: "title", overview: "Great story", inventory: 0, available_inventory: 0, release_date: "2017-4-17")

    rental_info = {
      rental: {
        customer_id: customer_one.id,
        movie_id: movie.id,
        due_date: "2019-11-14",
        checkout_date: "2019-11-07"
      }
    }

    post checkout_path(params: rental_info)

    must_respond_with :bad_request

    body = JSON.parse(response.body)
    body.must_equal "errors" => ["Not enough inventory"]

  end

  it "returns an error message if the input is incorrect" do
    invalid_rental_info = {
      rental: {
        customer_id: customer_one.id,
        movie_id: 44444444444,
        due_date: "2019-11-14",
        checkout_date: "2019-11-07",
      }
    }

    post checkout_path(params: invalid_rental_info)

    must_respond_with :bad_request

    body = JSON.parse(response.body)
    body.must_equal "errors" => ["Movie does not exist"]
  end

  let(:customer_one) { customers :customer_one}
  let(:movie_one) { movies :movie_one}

  it "won't change db if data is missing" do
    invalid_rental_info = {
      rental: {
        customer_id: customer_one.id,
        movie_id: movie_one.id,
        due_date: "2019-11-14",
        # checkout_date: "2019-11-07",
      }
    }

    proc {
      post checkout_path(params: invalid_rental_info)
    }.wont_change 'Rental.count'

    must_respond_with :bad_request
    body = JSON.parse(response.body)
    #this error message could change but just a sample of what we might want to output
    body.must_equal "errors" => {"checkout_date" => ["can't be blank"]}
  end

  describe "check_in" do
    let(:rental_one) { rentals :rental_one}
    let(:customer_one) { customers :customer_one}
    let(:movie_one) { movies :movie_one}

    it "is a working route" do
      post checkin_path(params: {customer_id: customer_one.id, movie_id: movie_one.id})
      must_respond_with :ok
    end

    it "returns a json" do
      post checkin_path(params: {customer_id: customer_one.id, movie_id: movie_one.id})
      response.header['Content-Type'].must_include 'json'
    end

    it "returns a hash" do
      post checkin_path(params: {customer_id: customer_one.id, movie_id: movie_one.id})
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "changes check_in from nil to today's date" do

    end
  end

  describe "overdue" do
  end


end
