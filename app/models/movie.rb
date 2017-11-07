class Movie < ApplicationRecord
  has_many :rentals
  has_many :cutomsters, :through => :rentals
  validates :title, presence: true
  validates :inventory, presence: true

end
