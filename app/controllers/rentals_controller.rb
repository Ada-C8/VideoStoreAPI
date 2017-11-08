class RentalsController < ApplicationController
  def create
    movie = Movie.find_by_id(rental_params[:movie_id])
    customer = Customer.find_by_id(rental_params[:customer_id])

    rental = Rental.new(movie: movie, customer: customer, due_date: rental_params[:due_date])

    if rental.valid? # rental has all attributes
      if movie.can_rent # the movie has enough available_inventory
        rental.save
        movie.update_available_inventory(-1)
        customer.update_customer_movies(1)
        render(
          json: {id: movie.id},
          status: :ok
        )
      else # movie doesn't have enough available_inventory
        render json: {errors: {movie_id: "Movie ID: #{rental_params[:movie_id]} is out of stock and cannot be rented right now. Please try again later"} },
        status: :bad_request
      end
    else # rental is missing attributes
      render json: {errors: rental.errors.messages},
      status: :bad_request
    end
  end

  def update
    movie = Movie.find_by_id(rental_params[:movie_id])
    customer = Customer.find_by_id(rental_params[:customer_id])
    rental = Rental.find_by(movie: movie, customer: customer)

    if rental # rental exists
      if rental.returned # rental has already been returned
        render json: {errors: {movie_id: "Movie ID: #{rental_params[:movie_id]} was already returned"} },
        status: :bad_request
      else # rental not returned yet
        rental.update(returned: true)
        movie.update_available_inventory(1)
        customer.update_customer_movies(-1)
        render(
          json: {id: params[:movie_id]},
          status: :ok
        )
      end
    else # rental does not exist based on combo of movie and customer id
      render json: {errors: "Rental does not exist."},
      status: :bad_request
    end
  end

private
  def rental_params
    params.permit(:movie_id, :customer_id, :due_date)
  end
end
