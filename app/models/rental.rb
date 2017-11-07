class Rental < ApplicationRecord
  RENTAL_PERIOD = 5
  belongs_to :movie
  belongs_to :customer

  before_validation :set_due_date

  validates :due_date, presence: true

  def checkin
    unless self.returned
      self.returned = true
      if self.save
        self.readonly!
        return true
      else
        return false
      end
    else
      errors.add(:returned, "Rental has already been returned. Cannot update.")
      return false
    end
  end

  private

    def set_due_date
      if self.due_date.nil?
        self.due_date = Date.today + RENTAL_PERIOD
      end
    end
end
