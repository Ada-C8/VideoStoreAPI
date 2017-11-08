class CustomersController < ApplicationController

  def index
    customers = Customer.all
    customers_array = []
    customers.each do |customer|
      customer_hash = customer.as_json(only: [:id, :name, :registered_at, :postal_code, :phone]).merge('movies_checked_out_count' => customer.checkout_count)
      customers_array << customer_hash
    end

    render(
      json: customers_array.to_json
    )
  end
end
