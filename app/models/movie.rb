class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  # validates :title, uniqueness: true, if: :uniq_year?
  #
  # def uniq_year?
  #   movies_array = Movie.where(title: self.title)
  #   return true if movies_array == []
  #
  #   years = movies_array.map {|movie| movie.release_date[0..3]}
  #
  #   years.include? self.release_date[0..3] ?
  #     false : true
  # end


  validates :overview, presence: true
  validates :release_date, presence: true, format: { with: /\d{4}\-\d{2}-\d{2}/}
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
