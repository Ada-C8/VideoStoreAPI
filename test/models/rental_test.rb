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
end
