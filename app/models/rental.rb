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
    currently_rented = Rental.currently_rented(movie_id.to_i)
    return true if currently_rented.length < inventory
    return false
  end

  def self.currently_rented(movie_id)
    return Rental.where(movie_id: movie_id.to_i, checkin_date: nil)
  end

  def self.overdue
    overdue_rentals = Rental.where(checkin_date: nil).where('due_date < ?', Date.today)
    overdue = overdue_rentals.map { |rental|
      {
        "title" => rental.movie.title,
        "customer_id" => rental.customer_id,
        "name" => rental.customer.name,
        "postal_code" => rental.customer.postal_code,
        "checkout_date" => rental.checkout_date,
        "due_date" => rental.due_date
      }
    }
    return overdue
  end
end
