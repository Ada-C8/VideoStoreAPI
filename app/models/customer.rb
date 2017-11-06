class Customer < ApplicationRecord
  has_many :rentals

  validates :name, presence: { message: "Please enter a name"}
end
