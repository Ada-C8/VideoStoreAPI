class RentalsController < ApplicationController

  def check_out
    rental = Rental.new
    rental.customer_id = params[:customer_id]
    rental.movie_id = params[:movie_id]
    rental.save

    if rental.checkout(params[:movie_id], params[:customer_id])
      # render json: Movie.find_by_id(params[:movie_id]), status: :created
      render json: rental.as_json(only: [:id, :checkout_date, :due_date, :customer_id, :movie_id]), status: :created
    else
      render json: {ok: false, message: "Exceeded available inventory!"}, status: :bad_request
    end
  end

  def check_in
    rental = Rental.find_by_id(params[:rental_id])
    rental.save
    if rental.checkin
      render json: rental.as_json(only: [:id, :checkout_date, :due_date]), status: :created
    else
      render json: {ok: false, error: "Customer has not checked out this movie yet."}, status: :bad_request
    end
  end

  def overdue

  end


end
