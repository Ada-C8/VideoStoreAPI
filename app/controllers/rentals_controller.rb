class RentalsController < ApplicationController

  def check_out
    rental = Rental.new
    rental.save
    if rental.checkout(params[:movie_id], params[:customer_id])
      # render json: Movie.find_by_id(params[:movie_id]), status: :created
      render json: rental.as_json(only: [:id, :checkout_date, :due_date]), status: :created
    else
      render json: {ok: false, message: "Exceeded available inventory!"}, status: :bad_request
    end
  end

  def check_in
    rental = Rental.new
    rental.save
    if rental.checkin(params[:movie_id], params[:customer_id])
      render json: rental.as_json(only: [:id, :checkout_date, :due_date]), status: :created
    else
      render json: {ok: false, error: "Customer has not checked out this movie yet."}, status: :bad_request
    end
  end

  def overdue
    
  end


end
