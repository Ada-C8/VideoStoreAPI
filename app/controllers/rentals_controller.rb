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
        json: { ok: false, message: "Insufficient inventory of selected movie -- cannot checkout"},
        status: :bad_request
      )
    end

  end

  def checkin
    rental = Rental.where(["customer_id = ? and movie_id = ?", params[:customer_id], params[:movie_id]])

    if rental.count == 0
      render(
        json: { errors: "No rental found" },
        status: :not_found
      )
      return
    elsif rental.count > 1
      rental.each do |elem|
        if elem.checkin_date == nil
          rental = elem
          break
        end
      end
    else
      rental = rental[0]
    end

    p rental
    if rental.checkout_date == nil
      render(
        json: { errors: rental.errors.messages },
        status: :not_found
      )
    else

      rental.checkin_date = rental.today
      rental.return_movie

      if rental.save
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
    rentals = Rental.all
    overdue_rentals = []
    rentals.each do |rental|
      if rental.is_overdue?
        overdue_rentals << rental
      end
    end
    return overdue_rentals
  end

  private
  def rental_params
    params.permit(:movie_id, :customer_id, :due_date)

  end
end
