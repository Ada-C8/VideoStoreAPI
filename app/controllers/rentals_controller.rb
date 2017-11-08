class RentalsController < ApplicationController

  def checkout
    rental = Rental.new(rental_params)
    rental.set_checkout

    if rental.valid? && rental.movie.rent
      rental.save
      rental.movie.save
      render json: rental.as_json(only: [:id]), status: :ok
    else
      render json: {ok: false}, status: :bad_request
    end
  end

  def check_in
    rental = Rental.where(rental_params, check_in: nil).first
    rental.set_check_in
    rental.movie.return
    rental.save
    rental.movie.save
  end

  private
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
