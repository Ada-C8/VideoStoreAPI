class Customer < ApplicationRecord
  # relationships
  has_many :rentals
  has_many :movies, through: :rentals

  # validations
  validates :name, presence: true
  validates :registered_at, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true

  def update_customer_movies(change)
    self.movies_checked_out_count = self.movies_checked_out_count + change
    self.save
  end
end
