require "test_helper"

describe Rental do
  let(:rental) { rentals(:rental1)}
  let(:rental2) { rentals(:rental2)}
  let(:movie1) { movies(:movie1)}
  let(:unavailable_movie) { movies(:movie2)}
  let(:bill) { customers(:bill)}


  describe 'relationships' do
    it "has a customer" do
      rental.must_respond_to :customer
      rental.must_be_kind_of Rental
      rental.customer.must_be_kind_of Customer
      rental.customer.must_equal bill
    end


    it "has an movie" do
      rental.must_respond_to :movie
      rental.must_be_kind_of Rental
      rental.movie.must_be_kind_of Movie
      rental.movie.must_equal movie1
    end
  end

  describe 'custom model tests' do

    it "decreases the availabile inventory when a movie is checked out " do
      rental.must_respond_to :remove_movie
      movie_count = Movie.find_by(id: rental.movie_id).available_inventory
      rental.remove_movie
      Movie.find_by(id: rental.movie_id).available_inventory.must_equal movie_count - 1
    end

    it "increases the customers movies_checked_out_count" do
      customer_count = Customer.find_by(id: rental.customer_id).movies_checked_out_count
      rental.remove_movie
      Customer.find_by(id: rental.customer_id).movies_checked_out_count.must_equal customer_count + 1
    end

    it "does not decrease the available inventory if insufficient inventory to checkout " do
      movie_count = Movie.find_by(id: rental2.movie_id).available_inventory
      rental2.remove_movie
      Movie.find_by(id: rental2.movie_id).available_inventory.must_equal movie_count
    end

    it "does not increase the customers movies_checked_out_count if insufficient inventory to checkout" do
      customer_count = Customer.find_by(id: rental2.customer_id).movies_checked_out_count
      rental2.remove_movie
      Customer.find_by(id: rental2.customer_id).movies_checked_out_count.must_equal customer_count
    end

    it "increases the available inventory when a movie is checked back in" do
      rental.must_respond_to :return_movie
      movie_count = Movie.find_by(id: rental.movie_id).available_inventory
      rental.return_movie
      Movie.find_by(id: rental.movie_id).available_inventory.must_equal movie_count + 1
    end

    it "decreases the customers movies_checked_out_count" do
      customer_count = Customer.find_by(id: rental.customer_id).movies_checked_out_count
      rental.return_movie
      Customer.find_by(id: rental.customer_id).movies_checked_out_count.must_equal customer_count - 1
    end

    it "does not increase the available inventory if a rental does not have a checkout date" do
      movie_count = Movie.find_by(id: rental2.movie_id).available_inventory
      rental2.return_movie
      Movie.find_by(id: rental2.movie_id).available_inventory.must_equal movie_count
    end

    it "does not decrease the customers movies_checked_out_count if insufficient inventory to checkout" do
      customer_count = Customer.find_by(id: rental2.customer_id).movies_checked_out_count
      rental2.return_movie
      Customer.find_by(id: rental2.customer_id).movies_checked_out_count.must_equal customer_count
    end

  end
end
