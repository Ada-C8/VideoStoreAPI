class Customer < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :postal_code, :account_credit
  validates :account_credit, numericality: true

end
