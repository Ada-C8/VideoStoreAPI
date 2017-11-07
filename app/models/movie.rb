class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: { message: "Movie must have a title"}

  validates :release_date, presence: { message: "Movie must have a release date"}
end
