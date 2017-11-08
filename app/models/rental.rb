class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :customer_id, presence: true, numericality: { only_integer: true }
  validates :movie_id, presence: true, numericality: { only_integer: true }
  validates :checkout_date, presence: true
  validates :due_date, presence: true


  def self.find_overdue
    #first check that check-in date is nil
    #then check if today's date is past the due date
    overdue_rentals = Rental.where(checkin_date: nil).where("due_date < ?", Date.today)

    overdue_rentals_array = []

    overdue_rentals.each do |rental|
      c = rental.customer
      overdue = {
        title: rental.movie.title,
        customer_id: rental.customer_id,
        name: c.name,
        postal_code: c.postal_code,
        checkout_date: rental.checkout_date,
        due_date: rental.due_date
      }
      overdue_rentals_array << overdue
    end

    return overdue_rentals_array
  end

end
