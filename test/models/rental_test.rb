require 'test_helper'

describe Rental do
  before do
    @rental = Rental.create(customer_id: 1, movie_id: 1)
  end

  describe 'attributes' do
    it "has all named attributes and responds to them" do
      @rental.must_respond_to :customer_id
      @rental.customer_id.must_equal 1

      @rental.must_respond_to :movie_id
      @rental.movie_id.must_equal 1

      @rental.must_respond_to :checkout_date
      @rental.must_respond_to :due_date
    end

    it "creates a string formatted checkout_date equal to the day of creation" do
      @rental.checkout_date.must_equal Date.today.strftime('%Y-%m-%d')
    end

    it "creates a string formatted due_date equal to 10 days after the day of creation" do
      @rental.due_date.must_equal (Date.today + 10).strftime('%Y-%m-%d')
    end

    it "can be created" do
      @rental = Rental.create(customer_id: 1, movie_id: 1)
      @rental.valid?.must_equal true
    end
  end

  describe "checkout method" do
    it "can be called on a rental object" do
      @rental.must_respond_to :checkout
    end

    it "returns true if a movie can be checked out" do
    end

    it "returns false if a movie cannot be checked out because the movie does not exist" do
      @rental.checkout(Movie.last.id + 1, Customer.first.id).must_equal false
    end

    it "returns false if a movie cannot be checked out because the customer does not exist" do
      @rental.checkout(Movie.last.id, Customer.last.id + 1).must_equal false
    end

    it "decrements available_inventory and returns false if a movie cannot be checked out because there are no more copies available" do
      #for a movie with 4 copies, 4 checkouts should go through
      movie = Movie.create(title: "A movie!", inventory: 4, overview: "blah", release_date: "2017-11-09")
      customer = Customer.create(name: "Me")
      rental = Rental.create(customer_id: customer.id, movie_id: movie.id)

      print movie.available_inventory
      rental.checkout(movie.id, customer.id).must_equal true
      print movie.available_inventory

      rental.checkout(movie.id, customer.id).must_equal true
      rental.checkout(movie.id, customer.id).must_equal true
      print movie.available_inventory

      rental.checkout(movie.id, customer.id).must_equal true

      #the last checkout should return false because there are no more copies left
      rental.checkout(movie.id, customer.id).must_equal false
    end
  end

  describe "checkin method" do
    before do
      @newrental = Rental.create(customer_id: Customer.first.id, movie_id: Movie.first.id)

      @badrental = Rental.create(customer_id: Customer.last.id, movie_id: Movie.last.id + 1)

      @anotherbadrental = Rental.create(customer_id: Customer.last.id + 1, movie_id: Movie.last.id)
    end

    it "can be called on a rental object" do
      @newrental.must_respond_to :checkin
    end

    it "returns true if a movie can be checked in" do
      @newrental.checkin.must_equal true
    end

    it "returns false if a movie cannot be checked in because the movie does not exist" do
      @badrental.checkin.must_equal false
    end

    it "returns false if a movie cannot be checked in because the customer does not exist" do
      @anotherbadrental.checkin.must_equal false
    end

    it "decrements movies checked out count and returns false if a movie cannot be checked out because there are no more copies checked out by customer" do
      @newrental.checkin.must_equal true
      @newrental.checkin.must_equal true
      @newrental.checkin.must_equal true
      @newrental.checkin.must_equal true

      @newrental.checkin.must_equal false
    end
  end

  describe "find overdue method" do
    it "returns an array" do
      Rental.find_overdue.must_be_kind_of Array
    end

    it "returns an array containing overdue rentals" do
      Rental.find_overdue.count.must_equal 1
      overdue = Rental.find_overdue[0]
      overdue.due_date.must_be :<, Date.today.strftime('%Y-%m-%d')
    end

    it "items returned are rental objects" do
      Rental.find_overdue[0].must_be_kind_of Rental
    end

    it "does not return rentals that are not overdue" do
      Rental.all.count.must_equal 3
      Rental.find_overdue.count.must_equal 1
    end

    it "succeeds with no rental objects" do
      Rental.destroy_all
      Rental.find_overdue.must_be_kind_of Array
      Rental.find_overdue.must_equal []
    end
  end
end
