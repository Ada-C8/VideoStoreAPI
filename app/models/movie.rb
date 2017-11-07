class Movie < ApplicationRecord
  has_many :customers, through: :rentals
  has_many :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true
end
