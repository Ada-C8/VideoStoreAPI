class Movie < ApplicationRecord
  has_many :rentals
  validates :title,
    presence: { message: "Movie title is required." },
    uniqueness: { message: "Movie title must be unique."}

  def available_inventory
    currently_rented = Rental.currently_rented(self.id)
    available_inventory = self.inventory - currently_rented.length
    return available_inventory
  end
end
