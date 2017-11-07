require 'date'

class RentalsController < ApplicationController
  def check_out
    rental = customer_id(movie_id)
    movie_id.available_inventory - 1
    rental.checkout_date = Date.new(Date.today)
  end

  def check_in

  end

  def overdue

  end

end
