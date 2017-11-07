class Movie < ApplicationRecord
  validates :title, presence: true
  validates :inventory, presence: true, numericality: true

  def available_inventory
    inventory
  end
end
