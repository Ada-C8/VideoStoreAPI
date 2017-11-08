class Movie < ApplicationRecord
  has_many :rentals, dependent: :nullify

  validates_presence_of :title, :release_date

  def available_inventory
    if self.out
      self.inventory - self.out
    else
      self.inventory
    end 
  end

  def rent
    if available_inventory > 0
      self.out += 1
    else
      return false
    end
  end

  def return
    if self.available_inventory < self.inventory
      self.out -= 1
    else
      false
    end
  end
end
