require 'date'

class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  RENTAL_PERIOD = 3

  def set_checkout
    self.checkout_date = Date.today.strftime( "%Y-%m-%d")
    self.due_date = (Date.today + RENTAL_PERIOD).strftime( "%Y-%m-%d" )
  end

  def set_check_in
    self.check_in = Date.today.strftime( "%Y-%m-%d")
  end

  def self.find_rental(rental_data = {})

    customer = Customer.find_by(id: rental_data[:customer_id])
    movie = Movie.find_by(id: rental_data[:movie_id])

    if customer && movie
      Rental.where(customer_id: customer.id, movie_id: movie.id, check_in: nil).first
    else
      return nil
    end

  end

end
