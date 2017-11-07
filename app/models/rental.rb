class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :movie_id, presence: true, numericality: true
  validates :customer_id, presence: true, numericality: true
  validates :checkout_date, presence: true

  after_initialize :set_defaults

  private

  def set_defaults
    self.checkout_date = Date.today
    (self.due_date = Date.today + 3) unless self.due_date
  end
end
