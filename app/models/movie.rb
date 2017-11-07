class Movie < ApplicationRecord
  has_many :rentals
  validates :title, presence: true

  def available_inventory
    return "hmmm"
  end
end
