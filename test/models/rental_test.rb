require "test_helper"

describe Rental do
  let(:rental_one){rentals(:one)}
  let(:customer){customers(:one)}
  let(:movie){movies(:Goonies)}
  let(:date_one){"2018-11-11"}

  describe "relationships" do
    it "has a customer" do
      rental_one.must_respond_to :customer
      rental_one.customer.must_be_kind_of Customer
    end

    it "has a movie" do
      rental_one.must_respond_to :movie
      rental_one.movie.must_be_kind_of Movie
    end

    # TODO: fill in these tests
    # it "allows one customer to have multiple movies" do
    #
    # end
    #
    # it "allows one movie to have many customers" do
    #
    # end
  end

  describe "validations" do
    it "can be created" do
      before = Rental.count
      new_rental = Rental.new(movie: movie, customer: customer, due_date: date_one)

      new_rental.must_be :valid?
      new_rental.save

      Rental.count.must_equal before + 1
    end

    it "it requires a movie" do
      rental = Rental.new(customer: customer , due_date: date_one)
      result = rental.save
      result.must_equal false
      rental.errors.messages.must_include :movie
    end

    it "requires a customer" do
      rental = Rental.new(movie: movie, due_date: date_one)
      result = rental.save
      result.must_equal false
      rental.errors.messages.must_include :customer
    end

    it "requires a due_date" do
      rental = Rental.new(movie: movie, customer: customer)
      result = rental.save
      result.must_equal false
      rental.errors.messages.must_include :due_date
    end
  end

  describe "custom methods" do
    describe "set_checkout_date" do
      it "will set checkout_date to todays today automatically after save" do
        rental = Rental.new(movie: movie, customer: customer, due_date: date_one)
        rental.checkout_date.must_be_nil
        rental.save
        rental.checkout_date.must_equal Date.today
      end
    end
  end
end
