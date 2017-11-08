class Rental < ApplicationRecord
  # relationships
  belongs_to :movie
  belongs_to :customer

  # validations
  validates :due_date, presence: true
  # don't need to validate that rentals are unique, a customer could check out the same movie on different occasions

  # method that will set checkout_date to todays date
  after_create :set_checkout_date

private

  def set_checkout_date
    self.checkout_date = Date.today
  end
end
