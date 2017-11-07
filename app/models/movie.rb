class Movie < ApplicationRecord
  has_many :rentals, dependent: :nullify

  validates_presence_of :title, :release_date

end
