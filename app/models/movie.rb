class Movie < ApplicationRecord
  has_many :rentals, dependent: :nullify
  has_many :customers, through: :rentals

end
