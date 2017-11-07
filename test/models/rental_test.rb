require "test_helper"

describe Rental do
  let(:valid_rental) {rentals(:one)}
  let(:valid_customer) {customers(:one)}
  let(:valid_movie) {movies(:one)}

  it "a rental can be saved to the database" do
    movie_id = Movie.find_by(title: valid_movie.title).id
    customer_id = Customer.find_by(name: valid_customer.name).id
    rental = Rental.new(
      movie_id: movie_id,
      customer_id: customer_id,
      due_date: Date.today + 5,
      checkout_date: Date.today
    )
    rental.save.must_equal true
  end

  describe "won't create invalid rental" do
    before do
      @invalid_rental = Rental.new()
      @invalid_rental.save
    end

    it "requires a valid customer_id" do
      @invalid_rental.errors.messages.must_include :customer_id
      @invalid_rental.errors.messages[:customer_id].must_include "Customer ID is required."
      @invalid_rental.errors.messages[:customer_id].must_include "Customer ID must be an integer."
    end

    it "requires a valid movie_id" do
      @invalid_rental.errors.messages.must_include :movie_id
      @invalid_rental.errors.messages[:movie_id].must_include "Movie ID is required."
      @invalid_rental.errors.messages[:movie_id].must_include "Movie ID must be an integer."
    end

    it "requires a due_date" do
      @invalid_rental.errors.messages.must_include :due_date
      @invalid_rental.errors.messages[:due_date].must_include "Due date is required."
    end

    it "requires a checkout_date" do
      @invalid_rental.errors.messages.must_include :checkout_date
      @invalid_rental.errors.messages[:checkout_date].must_include "Checkout date is required."
    end
  end
end
