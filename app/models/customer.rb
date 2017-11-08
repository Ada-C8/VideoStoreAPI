class Customer < ApplicationRecord
  has_many :rentals
  validates :name, presence: true

  def movies_checked_out_count
    return 0
  end
end
