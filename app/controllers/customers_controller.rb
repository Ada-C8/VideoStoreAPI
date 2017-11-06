class CustomersController < ApplicationController

  def index
    customers = Customer.customer_with_movie_count(Customer.all)

    render(
      json: customers.to_json(only: [:id, :name, :registered_at, :postal_code, :phone])
    )
  end
end
