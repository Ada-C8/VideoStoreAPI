class Movie < ApplicationRecord
  # belongs_to :customer
  validates :title, presence: true
  # validates :overview, presence: true
  # validates :release_date, presence: true
  # validates :inventory, presence: true
end
