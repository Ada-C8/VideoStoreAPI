class Rental < ApplicationRecord
  attr_reader :pretty_date

  belongs_to :movie
  belongs_to :customer

  # def pretty_date
  #   d = Date.parse(self.due_date)
  #   return d.strftime('%a %d %b %Y')
  # end

  def is_overdue?
    if self.due_date
      date = Date.parse(self.due_date)
      return true if date < Date.today
    end

    return false
  end

end
