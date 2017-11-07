class RentalsController < ApplicationController

  def index
    rentals = Rental.all

    render(
      :json => rentals.as_json(only: [:customer_id, :movie_id, :checkout_id, :due_date]),
      status: :ok
    )
  end

  def checkout
  end 
end
