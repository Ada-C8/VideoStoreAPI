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


  def self.available?(movie_id)
    inventory = Movie.find_by(id: movie_id.to_i).inventory
    currently_rented = Rental.where(movie_id: movie_id.to_i).where('checkout_date <= ?', Date.today).where('due_date >= ?', Date.today)
    return true if currently_rented.length < inventory
    return false
  end
end
