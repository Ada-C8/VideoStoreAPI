class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    if rental.save
      render json: {id: rental.id}
    else
      render json: {errors: rental.errors.messages}, status: :bad_request
    end
  end

  def checkin
    rental = Rental.find_by(movie_id: params[:movie_id], customer_id: params[:customer_id])
    if rental && rental.status == 'checked_out'
      rental.status = 'returned'
      rental.save!
      render json: {id: rental.status}
    else
      render json: {nothing: true}, status: :bad_request
    end
  end

  private
  def rental_params
    params.permit(:movie_id, :customer_id, :due_date)
  end
end
