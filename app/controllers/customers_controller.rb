class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(only: [:id, :name, :registered_at, :address, :phone, :city, :state, :postal_code, :account_credit]), status: :ok
  end
end
