class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, :through => :rentals
  validates :title, presence: true
  validates :inventory, presence: true

  def check_inventory
    if self.available_inventory >= 1
      return true
    end
    return false
  end

  def decrease_inventory(quantity)
    self.available_inventory -= quantity
    self.save
  end

end
