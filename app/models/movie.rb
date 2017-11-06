class Movie < ApplicationRecord
  validates :title, presence: true
  validates :release_date, presence: true
end
