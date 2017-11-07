class RentalsController < ApplicationController

  def checkout
    rental = Rental.new(rental_params)
    rental.set_checkout
    p rental.checkout_date
    p rental.due_date
    p rental.movie
    p rental.customer
    rental.save
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
