class RentalsController < ApplicationController
  def create
    puts "======================"
    puts "in controller"
    puts "======================"
    due_date_string = params[:due_date]
    due_date_var = Date.parse(due_date_string)
    rental = Rental.new(rental_params.merge(checkout_date: Date.today, due_date: due_date_var))
    if rental.save
      render(
        json: rental.as_json(only: [:id]),
        status: :ok
      )
    else
      render(
        json: {
          "ok" => false,
          "errors" => rental.errors.messages
        },
        status: :bad_request)
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
