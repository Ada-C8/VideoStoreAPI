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
      rental.due_date = pretty_date(rental.due_date)
      render json: rental.as_json(only: [:movie_id, :customer_id, :due_date]), status: :created
    else
      render json: { ok: false, errors: rental.errors }.as_json, status: :bad_request
    end


  end

  def check_in
    #updates existing Rental
    movie = Movie.find_by_id(params[:movie_id])
    customer = Customer.find_by_id(params[:customer_id])

    matching_rentals = Rental.where("movie_id = ? AND customer_id = ?", movie.id, customer.id)

    if matching_rentals.empty?
      render json: { ok: false, message: "No copy of #{movie.title} for #{customer.name} found" }, status: :not_found
    end

    checked_out = matching_rentals.where.not(due_date: nil)

    if checked_out.empty?
      render json: { ok: false, message: "No checked out copy of #{movie.title} for #{customer.name} found" }, status: :not_found
    end

    if checked_out.count > 0
      oldest_copy = checked_out.first
      oldest_copy.due_date = nil
        if oldest_copy.save
          movie.available_inventory += 1
          movie.save
          #error handling if movie doesn't save

          customer.movies_checked_out -= 1
          customer.save
          render json: { ok: true, message: " #{customer.name}'s copy of #{movie.title} has been checked in" }, status: :ok
          #error handling if customer doesn't save

        else
          return oldest_copy.errors
        end
    end
  end

  private

  def rental_params
    params.permit(:movie_id, :customer_id)
  end



end
