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
    # movie = Movie.find_by(id: params[:movie_id])
    # unless movie.check_inventory?
    #   render(
    #     json: {inventory: "Not enough inventory"},
    #     status: :bad_request
    #   )
    #   return
    # end

    if rental.save
      render(
        json: {id: rental.id}, status: :ok
      )
    else
      render(
        json: {errors: rental.errors.messages}, status: :bad_request
      )
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:customer_id, :movie_id, :checkout_date, :due_date)
  end

end
