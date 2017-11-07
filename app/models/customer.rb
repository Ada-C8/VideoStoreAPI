class Customer < ApplicationRecord
  has_many :rentals

  def movies_checked_out_count
    return 0
  end
end
