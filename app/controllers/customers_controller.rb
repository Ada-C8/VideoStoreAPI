class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(only: [:registered_at, :name, :address, :city, :state, :postal_code, :phone]), status: :ok
  end
end
