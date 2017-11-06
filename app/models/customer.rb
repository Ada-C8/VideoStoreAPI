class Customer < ApplicationRecord

  def self.index_customers
    customers = Customer.all
    customers_array = []
    customers.each do |customer|
      customer_hash = customer.as_json(only: [:id, :name, :registered_at, :postal_code, :phone]).merge('movies_checked_out_count' => 0)
      customers_array << customer_hash
    end
    return customers_array
  end

end
