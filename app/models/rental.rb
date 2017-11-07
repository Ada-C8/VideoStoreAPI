class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validate :cannot_create_a_rental_if_movie_inventory_will_become_negative


  def cannot_create_a_rental_if_movie_inventory_will_become_negative
    # checks if a movie's inventory will fall below 0 before initialization
    if self.movie.available_inventory - 1 < 0
      errors.add(:rental, "customer can't rent a movie if the movie's inventory will fall under 0 after renting")
    end
  end
end
