class Movie < ApplicationRecord
  has_many :rentals, dependent: :destroy

  validates :title, presence: true
  validates :release_date, presence: true, format: { with: /\d{4}-\d{2}-\d{2}/}
  validates :overview, presence: true
  validates :inventory, presence: true

end
