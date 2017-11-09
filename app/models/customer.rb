class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals

  def has_overdue?
    self.rentals.each do |rental|
      return true if rental.is_overdue?
    end

    return false
  end

  def find_overdue_rentals
    self.rentals.select{|rental| rental if rental.is_overdue?}
  end

  def build_overdue_array(rentals_array)
    overdues = []

    rentals_array.each do |rental|
      rental_info = {}
      movie = Movie.find_by(id: rental.movie_id)
      rental_info[:title] = movie.title
      rental_info[:checkout_date] = rental.checkout_date
      rental_info[:due_date] = rental.due_date

      overdues << rental_info
    end

    return overdues
  end
  
end
