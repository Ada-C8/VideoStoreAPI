require "test_helper"

describe Rental do

  #rentals YAML
  let(:rental_one) { rentals :rental_one }
  let(:rental_two) { rentals :rental_two }

  #customer YAML
  let(:customer_one) { customers :customer_one}
  let(:customer_two) { customers :customer_two}

  #movie YAML
  let(:movie_one) { movies :movie_one}
  let(:movie_two) { movies :movie_two}

  describe "relations" do
    it "has a customer" do
      rental_one.must_respond_to :customer
      rental_one.customer.must_be_kind_of Customer
    end

    it "has a movie" do
      rental_one.must_respond_to :movie
      rental_one.movie.must_be_kind_of Movie
    end

    it "allows one movie to have many customers" do
      movie_one.customers.count.must_be :>, 1
      # movie_one.customers.must_include customer_one
      # movie_one.customers.must_include customer_two
    end

    it "allows one customer to have many movies" do

    end

  end
  # it "must be valid" do
  #   value(rental).must_be :valid?
  # end
end
