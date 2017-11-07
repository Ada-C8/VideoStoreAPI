class RentalsController < ApplicationController

  def checkout
    rental = Rental.create(rental_params)

    rental.checkout_date = @checkout_date

    rental.save

    if rental.valid?
      render(
        json: rental, status: :ok
      )
    else
      render(
        json: { errors: rental.errors.messages },
        status: :bad_request
      )
    end
  end

  def checkin
  end

  def overdue
  end

  private
    def rental_params
      params.permit(:movie_id, :customer_id, :due_date)
    end
end
