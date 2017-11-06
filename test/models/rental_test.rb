require "test_helper"

describe Rental do
  let(:rental) { rentals(:rental1)}
  let(:movie1) { movies(:movie1)}
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
end
