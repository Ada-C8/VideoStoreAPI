class Movie < ApplicationRecord
  has_many :rentals

  validates :title, :overview, :release_date, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def available_inventory
    return (self.inventory - self.rentals.count)
  end
end
