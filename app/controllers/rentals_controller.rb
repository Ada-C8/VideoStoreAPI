class RentalsController < ApplicationController

def create
  rental = Rental.create(rental_params)
  if rental.save
    render json: movie, status: :created
  else
    render json: { errors: movie.errors.messages },
    status: :bad_request
  end
end

def update

end

def overdue

end

private

def rental_params
  params.require(:rental).permit(:due_date, :movie_id, :customer_id)
end

end
