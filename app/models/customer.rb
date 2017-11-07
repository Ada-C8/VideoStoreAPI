class Customer < ApplicationRecord
  has_many :rentals, dependent: :nullify
  has_many :movies, through: :rentals

  validates :name, presence: true
  validates :phone, presence: true

  def movies_checked_out_count
    return 0
  end

end
