class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie
  validates :customer_id, :movie_id, presence: true

# def self.due_date
#   due_date = (Date.today + 4.days)
# end

end
