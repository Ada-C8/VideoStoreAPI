class Customer < ApplicationRecord
  has_many :rentals

  def self.index_customers
    customers = Customer.all
    customers_array = []
    customers.each do |customer|
      customer_hash = customer.as_json(only: [:id, :name, :registered_at, :postal_code, :phone]).merge('movies_checked_out_count' => customer.checkout_count)
      customers_array << customer_hash
    end
    return customers_array
  end

  def checkout_count
    rentals = Rental.where(customer_id: self.id, checkin_date: nil)
    return rentals.length
  end

end
