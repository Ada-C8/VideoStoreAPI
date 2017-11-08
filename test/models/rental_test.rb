require "test_helper"

describe Rental do
  let(:rental) { Rental.new(
      movie_id: Movie.first.id,
      customer_id: Customer.first.id,
    )
  }

  describe 'validations' do
    it 'can be created if a customer checks out a movie (aka with valid data)' do
      rental.must_be :valid?
    end

    it 'requires movie_id' do
      rental.movie_id = nil

      rental.wont_be :valid?
      rental.errors.must_include 'movie_id'
    end

    it 'requires customer_id' do
      rental.customer_id = nil

      rental.wont_be :valid?
      rental.errors.must_include 'customer_id'
    end

    it 'defaults checkout_date to today' do
      rental.checkout_date.must_equal Date.today
    end

    it 'defaults due_date to 3 days later' do
      rental.due_date.must_equal (Date.today + 3)
    end

    it 'can take different due date' do
      rental.due_date = Date.today + 7

      rental.due_date.must_equal (Date.today + 7)
    end

    it "status defaults to checked out" do
      rental.status.must_equal "checked_out"
    end
  end
end
