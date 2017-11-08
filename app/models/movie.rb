class Movie < ApplicationRecord
  before_create :set_available_inventory
  validates :title, presence: true

  private
  def set_available_inventory
    self.available_inventory = self.inventory
  end 
end
