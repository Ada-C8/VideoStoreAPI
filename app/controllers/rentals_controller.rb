class RentalsController < ApplicationController
  def checkout
    @rental = Rental.new(rental_params)
    if @rental.save
      update_checkout
      render json: {id: @rental.id}
    else
      render json: {errors: @rental.errors.messages}, status: :bad_request
    end
  end

  def checkin
    @rental = Rental.find_by(movie_id: params[:movie_id], customer_id: params[:customer_id])
    if @rental
      if @rental.status == 'checked_out'
        @rental.status = 'returned'
        @rental.save

        update_checkin

        render json: {status: @rental.status}
      else
        render json: {:errors => {"rental" => "is already checked in"}}, status: :bad_request
      end
    else
      render json: {nothing: true}, status: :not_found
    end
  end

  def overdue
    render json: Rental.overdue.as_json
  end

  private
  def rental_params
    params.permit(:movie_id, :customer_id, :due_date)
  end

  def update_checkout
    movie, customer = @rental.movie, @rental.customer
    movie.available_inventory -= 1
    movie.save
    customer.movies_checked_out_count += 1
    customer.save
  end

  def update_checkin
    movie, customer = @rental.movie, @rental.customer
    movie.available_inventory += 1
    movie.save
    customer.movies_checked_out_count -= 1
    customer.save
  end
end
