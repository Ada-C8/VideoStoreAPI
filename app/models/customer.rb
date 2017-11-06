class Customer < ApplicationRecord
  validates :name, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true

  def registered_at # part of validation testing
    return self.created_at
  end

  #==========================#
  
end
