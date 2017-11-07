class RentalsController < ApplicationController

  def check_out(movie_id, customer_id)
    movie = Movie.find_by_id(movie_id)
    customer = Customer.find_by_id(customer_id)
    if movie && movie.available_inventory > 0
      movie.available_inventory -= 1
    else
      error
    end
    if customer
      customer.movies_checked_out_count += 1
    else
      error
    end
      ++ render json status 201 created
    end

    def check_in
    end
    
    def overdue
    end


  end
