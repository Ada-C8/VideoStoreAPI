class RentalsController < ApplicationController

  def check_out(movie_id, customer_id)

    movie = Movie.find_by_id(movie_id)
    customer = Customer.find_by_id(customer_id)

    if customer && movie && movie.available_inventory > 0
      movie.available_inventory -= 1
      customer.movies_checked_out_count += 1
      render json: {ok: true}, status: :created
    else
      render json: {ok: false}, status: :bad_request
    end
  end

  def check_in
  end

  def overdue
  end


end
