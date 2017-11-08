class Movie < ApplicationRecord
  has_many :rentals

  validates :title, :inventory, presence: true

  # this method shows the availible inventory for a specific movies_path
  # when this method is called in the show action for movie (:available_inventory) it knows that self is the instance of movie that 'movie' points to without having to pass any parameters to this method
  def available_inventory
    (self.inventory) - (self.rentals.where(checked_out: true).count)
  end

end
