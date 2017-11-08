require 'date'

class RentalsController < ApplicationController
  def check_out
    movie = Movie.find_by_id(params[:movie_id])
    customer = Customer.find_by_id(params[:customer_id])

    if movie.check_inventory
      rental = Rental.create(customer: customer, movie: movie, due_date: Date.today + 1.day)
    end

    if movie.check_inventory
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

    movie.update(available_inventory: movie.available_inventory - 1)
    customer.update(movies_checked_out_count: customer.movies_checked_out_count + 1)
  end


  def check_in
    movie = Movie.find_by_id(params[:movie_id])
    customer = Customer.find_by_id(params[:customer_id])
    rental = Rental.find_by_id(params[:rental_id])
    
    movie.update(available_inventory: movie.available_inventory + 1)
    customer.update!(movies_checked_out_count: customer.movies_checked_out_count - 1)
    if movie.save
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

  def overdue

  end
end
