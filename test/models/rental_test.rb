require "test_helper"

describe Rental do

  describe "relations" do

    it "has a customer" do
      r = rentals(:one)
      r.must_respond_to :customer
      r.customer.must_be_kind_of Customer
    end

    it "has a movie" do
      r = rentals(:one)
      r.must_respond_to :movie
      r.movie.must_be_kind_of Movie
    end
  end

  describe "validations" do
    let(:customer1){customers(:one)}
    let(:customer2){customers(:two)}
    let(:movie1){movies(:one)}
    let(:movie2){movies(:two)}

    it "allows customer to rent multiple movies" do
      Rental.create(customer: customer1, movie: movie1)
      rental2 = Rental.new(customer: customer1, movie: movie2)
      rental2.valid?.must_equal true
    end

    it "allows multiple customers to rent a movie" do
      Rental.create(customer: customer1, movie: movie1)
      rental2 = Rental.new(customer: customer2, movie: movie1)
      rental2.valid?.must_equal true
    end

    it "doesn't allow customer to rent a movie if its available inventory is 0" do
      movie_inventory = movie1.inventory
      movie_inventory.times do
        Rental.create(customer: customer1, movie: movie1)
      end
      new_rental = Rental.new(customer: customer2, movie: movie1)
      new_rental.valid?.must_equal false

    end

  end

end
