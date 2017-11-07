class Movie < ApplicationRecord
  has_many :rentals
  validates :title, presence: { message: "Movie title is required." }, uniqueness: { message: "Movie title must be unique." }
end
