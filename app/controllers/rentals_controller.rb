require 'date'

class RentalsController < ApplicationController
  def check_out
    movie = Movie.find_by_id(params[:movie_id])
    customer = Customer.find_by_id(params[:customer_id])

    # if @movie.check_inventory
    rental = Rental.create(customer: customer, movie: movie, due_date: Date.today + 1.day)

    movie.update(available_inventory: movie.available_inventory - 1)
    customer.update(movies_checked_out_count: customer.movies_checked_out_count + 1)
    # end
  end

  def check_in

  end

  def overdue

  end
end
