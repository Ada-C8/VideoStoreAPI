class Movie < ApplicationRecord
  before_create :set_available_inventory

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, numericality: { only_integer: true, greater_than: -1 }

  private

  def set_available_inventory
    self.available_inventory = self.inventory
  end
end
