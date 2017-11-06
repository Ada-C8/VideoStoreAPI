class Customer < ApplicationRecord
  attr_accessor :movies_checked_out_count

  def self.customer_with_movie_count(array_of_customers)
    array_of_customers.each do |customer|
      customer.movies_checked_out_count = 0
    end
    return array_of_customers
  end
end
