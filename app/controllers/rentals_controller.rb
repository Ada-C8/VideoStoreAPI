class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    if rental.save
      render json: {id: rental.id}
    else
      render json: {errors: rental.errors.messages}, status: :bad_request
    end
  end

  private
  def rental_params
    params.permit(:movie_id, :customer_id, :due_date)
  end
end
