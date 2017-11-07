class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :customer_id, presence: true, numericality: { only_integer: true }
  validates :movie_id, presence: true, numericality: { only_integer: true }
  validates :checkout_date, presence: true
  validates :due_date, presence: true


  # def inventory?
  #   movie = movie.find_by(id: params[:movie_id])
  #   if movie.inventory < 1
  #     return false
  #   end
  # end

end
