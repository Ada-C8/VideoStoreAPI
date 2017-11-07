class RentalsController < ApplicationController

  def checkout
    rental = Rental.new(rental_params)

    if rental.remove_movie
      # if sufficient inventory to remove the movie, set checkout date and save
      rental.checkout_date = rental.today
      rental.save
      # if valid save, return ok status
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
    else
      render(
        json: { ok: false, message: "Insufficient inventory of select movie -- cannot checkout"},
        status: :bad_request
      )
      return
    end


  end

  def checkin
    rental = Rental.find_by(id: params[:id])

    unless rental
      render(
        json: { errors: rental.errors.messages },
        status: :not_found
      )
    end

    if rental.checkout_date == nil
      render(
        json: { errors: rental.errors.messages },
        status: :not_found
      )
    else

      rental.checkin_date = rental.today

      rental.save

      if rental.valid?
        render(
          json: rental, status: :ok
        )
      else
        render(
          json: { errors: rental.errors.messages },
          status: :not_found
        )
      end
    end
  end

  def overdue
  end

  private
  def rental_params
    params.permit(:movie_id, :customer_id, :due_date)
  end
end
