class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie
  validates :due_date, presence: true
  validates :check_out_date, presence: true
  validate :movie_available?, :on => :create

  def movie_available?
    movie = self.movie
    if movie && !(movie.available?)
      self.errors[:movie] << "does not have any available inventory."
    end
  end
end
