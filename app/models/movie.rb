class Movie < ApplicationRecord
  has_many :rentals, dependent: :nullify
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :release_date, presence: true
  validates :inventory, numericality: {only_integer: true, greater_than: 0 }

  def available_inventory
    return 0
  end
end
