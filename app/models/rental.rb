class Rental < ApplicationRecord
  attr_reader :pretty_date

  belongs_to :movie
  belongs_to :customer

  def self.pretty_date
    d = Date.parse(self.due_date)
    return d.strftime('%a %d %b %Y')
  end

end
