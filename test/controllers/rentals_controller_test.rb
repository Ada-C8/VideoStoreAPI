require "test_helper"

describe RentalsController do
  describe "checkout" do
    it "is a working route" do
      post checkout_path
      must_respond_with :success
    end

    it "return json" do
      post checkout_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      post checkout_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "increases the number of rentals in db" do
      rental_count = Rental.count
      post checkout_path

      Rental.count.must_equal (rental_count + 1)
    end

    it "returns cust id, movie id and due date" do
      keys = %w(customer_id due_date movie_id)

      post checkout_path
      body = JSON.parse(response.body)
      body.each do |checkout|
        checkout.keys.sort.must_equal keys
      end
    end


    it "returns an error message if not enough inventory" do
      skip
    end


    it "returns an error message if the input is incorrect" do
      skip
    end

    it "won't change db if data is missing" do
      let(:customer_one) { customers :customer_one}
      let(:movie_one) { movies :movie_one}

      invalid_rental_info = {
        customer_id: customer_one,
        movie_id: movie_one,
        due_date: "2017-11-14",
        # checkout_date: "2017-11-07",
      }

      proc {
        post checkout_path, params: {rental: invalid_rental_info}
      }.wont_change 'Rental.count'

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      #this error message could change but just a sample of what we might want to output
      body.must_equal "errors" => {"checkout_date" => ["can't be blank"]}
    end

  end
end
