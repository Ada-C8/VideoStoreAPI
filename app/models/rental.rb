class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :due_date, presence: true, format: { with: /\d{4}-\d{2}-\d{2}/}
  # validate :overdue

  private

  def overdue
     if Date.parse(self.due_date) < Date.today()
       errors.add(:due_date, "is over due")
     end
  end

end
