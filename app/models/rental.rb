require 'date'

class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  def today
    @today = Date.today

    @today.strftime('%Y-%m-%d')
  end

  def remove_movie
    movie = Movie.find_by(id: self.movie_id)
    customer = Customer.find_by(id: self.customer_id)

    if movie && customer
      if movie.available_inventory >= 1
        movie.available_inventory -= 1
        movie.save

        customer.movies_checked_out_count += 1
        customer.save
      else
        return false
      end
    else
      return false
    end
  end

  def return_movie
    movie = Movie.find_by(id: self.movie_id)
    customer = Customer.find_by(id: self.customer_id)

    if self.checkout_date != nil && movie && customer
      movie.available_inventory += 1
      movie.save

      customer.movies_checked_out_count -= 1
      customer.save
    else
      return false
    end
  end


  def due_date_check

  end


end
