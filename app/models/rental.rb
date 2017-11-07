class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :customer_id,
    presence:
      { message: "Customer ID is required." },
    numericality:
      {only_integer: true, message: "Customer ID must be an integer."}
  validates :movie_id,
    presence:
      { message: "Movie ID is required."},
    numericality:
      {only_integer: true, message: "Movie ID must be an integer."}
  validates :due_date,
    presence:
      { message: "Due date is required." }
  validates :checkout_date,
    presence:
      { message: "Checkout date is required." }
end
