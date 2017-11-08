class RentalsController < ApplicationController

  def check_out
    movie = Movie.find_by_id(params[:movie_id])
    customer = Customer.find_by_id(params[:customer_id])

    unless movie.available_inventory > 0
      return render json: { ok: true, message: "All copies of #{movie.title} are checked out." }, status: :ok
    end

    rental = Rental.new(rental_params)
    week_from_today = Date.today + 7
    rental.due_date = week_from_today.to_s


    if rental.save
      movie.available_inventory -= 1
      movie.save
      customer.movies_checked_out += 1
      customer.save

      # render json: rental.as_json(only: [:movie_id, :customer_id, :pretty_date]), status: :ok
      render json: rental, status: :created


    else
      render json: { ok: false, errors: rental.errors }.as_json, status: :bad_request
    end


  end

  def check_in

  end

  def overdue

  end

  private

  def rental_params
    params.permit(:movie_id, :customer_id)
  end


end
