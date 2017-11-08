require "test_helper"

describe RentalsController do
  describe 'check_out' do
    # it "has a customer_id, movie_id, and due_date" do
    #
    # end

    it "successfully removes a movie from available_inventory" do
      customer = customers(:one)
      movie = movies(:two)

      before_inventory = movie.available_inventory
      before_checked_out = customer.movies_checked_out_count
      post checkout_path, params: {
        movie_id: movie.id,
        customer_id: customer.id
      }

      must_respond_with :success

      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash

      movie.reload
      movie.available_inventory.must_equal before_inventory - 1

      customer.reload
      customer.movies_checked_out_count.must_equal before_checked_out + 1
    end

    it "doesn't check out a movie if avialable_inventory is 0" do
      customer = customers(:one)
      movie = movies(:three)
      post checkout_path, params: {
        movie_id: movie.id,
        customer_id: customer.id
      }
      must_respond_with :bad_request
    end

    # it "doesn't check out a movie if customer doesn't exist" do
    # end
  end

  describe "check_in" do
    it "has a customer_id and movie_id" do

    end

    it "adds one to the available_inventory" do
    end

    it "fails if available_inventory is the same as inventory" do

    end

  end

  describe "overdue" do
    it "has title, customer_id, name, postal_code, checkout_date, and due_date" do

    end

    it "isn't errors if it isn't truly overdue" do
    end


  end
end
