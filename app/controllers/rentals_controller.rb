class RentalsController < ApplicationController

def checkout
  rental = Rental.create(rental_params)
  if rental.save
    render json: movie, status: :ok #keep ok status to prevent smoke fail
  else
    render json: { errors: rental.errors.messages },
    status: :bad_request
  end
end

def checkin

end

def overdue

end

private

def rental_params
  params.permit(:due_date, :movie_id, :customer_id)
end

end
