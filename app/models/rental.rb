require 'date'

class Rental < ApplicationRecord
  before_create :format_checkout, :format_due_date

  private
  def format_checkout
    checkout_date = Date.today.strftime('%Y-%m-%d')
  end

  def format_due_date
    due_date = (Date.today + 10).strftime('%Y-%m-%d')
  end

end
