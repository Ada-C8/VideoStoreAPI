class Rental < ApplicationRecord
  RENTAL_PERIOD = 5
  belongs_to :movie
  belongs_to :customer

  before_create :set_due_date

  validates :due_date, presence: true

  private

    def set_due_date
      self.due_date = Date.today + RENTAL_PERIOD
    end
end
