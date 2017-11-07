class Movie < ApplicationRecord
  has_many :rentals, dependent: :nullify
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :release_date, presence: true
  validates :inventory, numericality: {only_integer: true, greater_than: 0 }

  def available_inventory
    unavailable = Rental.where(movie_id: self.id, returned: false).count

    available = self.inventory - unavailable

    return available
  end

  def available?
    return self.available_inventory > 0
  end
end
