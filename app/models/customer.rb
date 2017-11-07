class Customer < ApplicationRecord
  has_many :rentals

  validates :name, :registered_at, :address, :city, :state, :postal_code, :phone, presence: true
  validates :account_credit, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
