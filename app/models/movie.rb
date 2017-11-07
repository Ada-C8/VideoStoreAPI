class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true


  def check_inventory?

    if self.inventory < 1
      return false
    else
      return true
    end
  end

  def reduce_inventory
    self.inventory = self.inventory - 1

    self.save
  end

  def increase_inventory
    self.inventory = self.inventory + 1

    self.save
  end
end
