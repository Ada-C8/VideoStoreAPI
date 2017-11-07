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
    if movie
      if movie.available_inventory >= 1
        movie.available_inventory -= 1
      else
        return false
      end
    else
      return false
    end 
  end

  def return_movie
    movie = Movie.find_by(id: rental.movie_id)
    movie.available_inventory += 1
    movie.save
  end

end
