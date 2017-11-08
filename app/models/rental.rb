require 'date'

class Rental < ApplicationRecord

  before_create :format_checkout, :format_due_date

  def checkout(movie_id, customer_id)

    movie = Movie.find_by_id(movie_id)
    customer = Customer.find_by_id(customer_id)

    if customer && movie && movie.available_inventory > 0
      movie.available_inventory -= 1
      movie.save
      customer.movies_checked_out_count += 1
      customer.save
      return true
    else
      return false
    end
  end

  def checkin

    customer = Customer.find_by_id(self.customer_id)
    movie = Movie.find_by_id(self.movie_id)

    if customer && movie && customer.movies_checked_out_count > 0
      movie.available_inventory += 1
      movie.save
      customer.movies_checked_out_count -= 1
      customer.save
      return true
    else
      return false
    end
  end

  private

  def format_checkout
    self.checkout_date = Date.today.strftime('%Y-%m-%d')
  end

  def format_due_date
    self.due_date = (Date.today + 10).strftime('%Y-%m-%d')
  end

end
