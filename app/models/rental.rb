require 'date'

class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  def today
    @today = Date.today

    @today.strftime('%Y-%m-%d')
  end

end
