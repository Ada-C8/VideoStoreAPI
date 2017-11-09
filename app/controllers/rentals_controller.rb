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
    rental = Rental.find_rental(rental_params)

    if rental && rental.movie.return
      rental.set_check_in
      rental.save
      rental.movie.save
      render json: rental.as_json(only: [:id]), status: :ok
    else
      render json: {ok: false}, status: :bad_request
    end

  end

  private
  def rental_params
    params.permit(:customer_id, :movie_id)
  end


end
