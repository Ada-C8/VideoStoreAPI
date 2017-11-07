class RentalsController < ApplicationController
  def create
    due_date_string = params[:due_date]
    due_date_var = Date.parse(due_date_string)
    rental = Rental.new(rental_params.merge(checkout_date: Date.today, due_date: due_date_var))
    if rental.valid?
      if Rental.available?(params[:movie_id])
        rental.save
        render(
          json: rental.as_json(only: [:id]),
          status: :ok
        )
      else
        render(
          json: {
            "ok" => false,
            "errors" => ["Requested movie is not in stock."]
          },
          status: :bad_request)
      end
    else
      render(
        json: {
          "ok" => false,
          "errors" => rental.errors.messages
        },
        status: :bad_request)
    end
  end

  def update
    rental = Rental.find_by(movie_id: params[:movie_id], customer_id: params[:customer_id])
    if rental
      rental.checkin_date = Date.today
      rental.save
      render(
        json: rental.as_json(only: [:id]),
        status: :ok
      )
    else
      render(
        json: {
          "ok" => false,
          "errors" => ["Rental does not exist."]
        },
        status: :bad_request)
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end

end
