class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates_presence_of :customer, :movie, :checkout_date, :due_date

end
