require 'date'

class RentalsController < ApplicationController
  def check_out
    movie = Movie.find_by_id(params[:movie_id])
    customer = Customer.find_by_id(params[:customer_id])
    rental = Rental.find_by_id(params[:id])

    if movie.check_inventory

      puts movie.inventory
      puts movie.available_inventory
      rental = Rental.create(customer: customer, movie: movie, due_date: Date.today + 1.day)
      movie.decrease_inventory
      customer.add_checkout_count
      render(
      json: { id: rental.id },
      status: :ok
      )
    else
      render(
      json: { errors: movie.errors.messages },
      status: :bad_request
      )
    end
  end
  def check_in

    movie = Movie.find_by_id(params[:movie_id])
    customer = Customer.find_by_id(params[:customer_id])
    rental = Rental.find_by_id(params[:id])

    if movie.check_if_checked_out
      movie.increase_inventory
      customer.decrease_checkout_count
      render(
      json: { id: rental },
      status: :ok
      )
      
    else
      render(
      json: { errors: movie.errors.messages },
      status: :bad_request
      )
    end

  end

  def overdue

  end
end
