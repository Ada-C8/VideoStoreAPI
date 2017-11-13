class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :customer, presence: {messsage: "rental must have a customer"}
  validates :movie, presence: {messsage: "rental must have a movie"}
end
