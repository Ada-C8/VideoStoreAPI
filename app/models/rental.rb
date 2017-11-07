require 'date'

class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  RENTAL_PERIOD = 3

  def set_checkout
    self.checkout_date = Date.today.strftime( "%Y-%m-%d ")
    self.due_date = (Date.today + RENTAL_PERIOD).strftime( "%Y-%m-%d" )
  end
end
