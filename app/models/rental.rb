class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :movie_id, presence: true, numericality: true
  validates :customer_id, presence: true, numericality: true
  validates :checkout_date, presence: true

  after_initialize :set_defaults

  def self.overdue
    Rental.all.find_all do |rental|
      Date.today > rental.due_date && rental.status == 'checked_out'
    end
  end

  private

  def set_defaults
    self.checkout_date ||= Date.today
    (self.due_date ||= Date.today + 3)
    self.status ||= "checked_out"
  end
end
