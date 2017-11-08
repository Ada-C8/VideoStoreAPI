class Customer < ApplicationRecord
  # include ActiveModel::Serialization

  has_many :rentals

  validates :name, presence: true

  # this method calculates the number of movies checked out for the index action for customer
  # when we render json in the index action it knows to run this method for each instance of Customer (treating the each instance as self) without having to pass any parameters to this method.
  def movies_checked_out_count
    self.rentals.where(checked_out: true).count
  end # movies_checked_out

end
