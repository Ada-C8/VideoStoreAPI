class CustomersController < ApplicationController
  def index
    customers = Customer.all

    render(
      json: customers.as_json(only: [:name, :registered_at, :address, :city, :state, :postal_code, :phone, :account_credit]),
      status: :ok
    )
  end
end
