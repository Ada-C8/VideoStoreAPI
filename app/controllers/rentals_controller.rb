class RentalsController < ApplicationController
  def checkin
  end

  def checkout
    rental = Rental.new rental_params
    rental.due_date = (Date.today() + 4).to_s
    if rental.save
      render json: rental.as_json(only: [:customer_id, :movie_id, :due_date])
    else
      render json: {errors: rental.errors.messages}, status: :bad_request
    end
  end

  def overdue
  end

  private
  def rental_params
    params.require(:rental).permit(:customer_id, :movie_id)
  end
end
