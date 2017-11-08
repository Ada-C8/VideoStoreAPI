class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, :through => :rentals

  validates :name, presence: true
  validates :phone, presence: true
  def add_checkout_count
    self.movies_checked_out_count += 1
    self.save
  end

  def decrease_checkout_count
    self.movies_checked_out_count -= 1
    self.save
  end
end
