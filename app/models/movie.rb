class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true, format: { with: /\d{4}\-\d{2}-\d{2}/}
  validates :inventory, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

end
