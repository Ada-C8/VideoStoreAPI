require 'date'

class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  def checkout_date
    @checkout_date = Date.today

    @checkout_date.strftime('%Y-%m-%d')

  end
end
