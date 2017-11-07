class Customer < ApplicationRecord
  has_many :rentals, dependent: :nullify

  validates_presence_of :name, :postal_code, :phone, :registered_at

end
