class Rental < ApplicationRecord
  validates :due_date, presence: true
  validates :customer_id, presence: true
  validates :movie_id, presence: true
end
