class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true


  def self.inventory?
    # movie = Movie.find_by(id: params[:movie_id])
    if movie.inventory < 1
    # if inventory < 1
      return false
    end
  end
end
