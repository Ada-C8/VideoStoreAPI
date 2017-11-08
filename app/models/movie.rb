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

  def check_if_checked_out
    if self.available_inventory < self.inventory
      return true
    else
      return false
    end 
  end

  def decrease_inventory
    self.available_inventory -= 1
    self.save
  end

  def increase_inventory
    self.available_inventory += 1
    self.save
  end


end
