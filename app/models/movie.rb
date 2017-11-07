class Movie < ApplicationRecord
  validates :title, presence: { message: "Movie title is required." }, uniqueness: { message: "Movie title must be unique." }
end
