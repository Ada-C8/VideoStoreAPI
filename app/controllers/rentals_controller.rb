class RentalsController < ApplicationController

  def index
    rentals = Rental.all

    render(
      :json => rentals.as_json(only: [:customer_id, :movie_id, :checkout_id, :due_date]),
      status: :ok
    )
  end

  def checkout
    rental = Rental.new(rental_params)
    movie = rental.movie

    if movie.nil?
      render(
      json: {errors: ["Movie does not exist"]},
      status: :bad_request
      )
      return
    end

    unless movie.check_inventory?
      render(
        json: {errors: ["Not enough inventory"]},
        status: :bad_request
      )
      return
    end

    if rental.save
      movie.reduce_inventory!
      render(
        json: {id: rental.id}, status: :ok
      )
    else
      render(
        json: {errors: rental.errors.messages}, status: :bad_request
      )
    end
  end

  def check_in
    # find the rental instance
    rental = Rental.where(customer_id: params[:customer_id], movie_id: params[:movie_id]).order(due_date: :asc).first

    if rental.nil?
      render(
      json: {errors: ["Rental not found"]},
      status: :not_found
      )
      return
    else
      rental.checkin_date = Date.today
      rental.save

      rental.movie.increase_inventory!

      render(
        json: { }
      )
    end
  end

  def overdue

  end


  private

  def rental_params
    params.require(:rental).permit(:customer_id, :movie_id, :checkout_date, :due_date)
  end

end
