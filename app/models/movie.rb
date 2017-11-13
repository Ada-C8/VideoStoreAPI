class Movie < ApplicationRecord
  validates :title, presence: true

  def available?
    if self.available_inventory > 0
      return true
    else
      return false
    end
  end
end
