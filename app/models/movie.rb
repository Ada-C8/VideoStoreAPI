class Movie < ApplicationRecord
  validates :title, presence: true

  before_create :set_default_avaiable_inventory

  private

  def set_default_avaiable_inventory
    self.available_inventory = self.inventory
  end
end
