require "test_helper"

describe Rental do

  #rentals YAML
  let(:rental_one) { rentals :rental_one }
  let(:rental_two) { rentals :rental_two }
  let(:rental_three) { rentals :rental_three }
  let(:rental_four) { rentals :rental_four }

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
      movie_one.customers.must_include customer_one
      movie_one.customers.must_include customer_two
    end

    it "allows one customer to have many movies" do
      customer_one.movies.count.must_be :>, 1
      customer_one.movies.must_include movie_one
      customer_one.movies.must_include movie_two
    end

  end

  describe "valid" do
    it "will return false without a customer id" do
      rental_one.customer_id = nil
      rental_one.wont_be :valid?
    end

    it "will return false if customer id is not a number" do
      rental_one.customer_id = " "
      rental_one.wont_be :valid?
    end

    it "will return false without a movie id" do
      rental_one.movie_id = nil
      rental_one.wont_be :valid?
    end

    it "will return false if movie id is not a number" do
      rental_one.movie_id = " "
      rental_one.wont_be :valid?
    end

    it "will return false without a checkout date" do
      rental_two.checkout_date = nil
      rental_two.wont_be :valid?
    end

    it "will return false without a due date" do
      rental_three.due_date = nil
      rental_three.wont_be :valid?
    end


  end
end
