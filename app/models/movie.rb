class Movie < ApplicationRecord
  before_create :set_available_inventory
  has_many :rentals, dependent: :destroy

  validates :title, presence: true
  validates :release_date, presence: true, format: { with: /\d{4}-\d{2}-\d{2}/}
  validates :overview, presence: true
  validates :inventory, presence: true
  validate :available_to_rent

  private
  def set_available_inventory
    self.available_inventory = self.inventory
  end

  def available_to_rent
    if self.available_inventory <= 0
      errors.add(:available_inventory, "is not available")
    end
  end
end
