class Customer < ApplicationRecord
  has_many :rentals

  validates_presence_of :name, :address, :city, :state, :postal_code, :account_credit
  validates :account_credit, numericality: true

  after_initialize :set_defaults

  private

  def set_defaults
    self.account_credit ||=  0.0
    self.movies_checked_out_count ||= 0
  end
end
