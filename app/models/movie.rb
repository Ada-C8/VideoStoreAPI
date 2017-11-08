class Movie < ApplicationRecord
  has_many :rentals

  validates :title, :overview, :release_date, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # validates :release_date, presence: true, format: { with: /[\d][\d][\d][\d]-[\d][\d]-[\d][\d]/}

  validate :cannot_create_with_an_invalid_date

  def cannot_create_with_an_invalid_date
    if self.release_date
      begin
        self.release_date.to_date
      rescue ArgumentError
        errors.add(:movie, "cannot create with an invalid date")
      else
        self.release_date.to_date.strftime('%Y-%m-%d')
      end
    end
  end

  def available_inventory
    return (self.inventory - self.rentals.count)
  end

end
