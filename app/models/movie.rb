class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :inventory, presence: true, numericality: true

  after_initialize :set_defaults

  private

  def set_defaults
    self.available_inventory ||= self.inventory
  end
end
