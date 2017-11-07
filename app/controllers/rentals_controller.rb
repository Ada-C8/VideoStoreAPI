class RentalsController < ApplicationController

  def check_out
    rental = Rental.new
    rental.save
    if rental.checkout(params[:movie_id], params[:customer_id])
      # render json: Movie.find_by_id(params[:movie_id]), status: :created
      render json: rental.as_json(only: [:id, :checkout_date, :due_date]), status: :created

    else
      render json: {ok: false}, status: :bad_request
    end
  end

  def check_in(movie_id, customer_id)
    movie = Movie.find_by_id(movie_id)
    customer = Customer.find_by_id(customer_id)

    if customer && movie && customer.movies_checked_out_count > 0
      movie.available_inventory += 1
      customer.movies_checked_out_count -= 1
      render json: {ok: true}, status: :created
    else
      render json: {ok: false}, status: :bad_request
    end
  end

  def overdue
  end


end
