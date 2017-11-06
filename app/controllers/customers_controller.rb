class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render(
      json: customers.as_json(only: [:name, :registered_at, :address, :city, :state, :postal_code, :phone, :account_credit]),
      status: :ok
    )
  end

  def show
    customer = Customer.find_by_id(params[:id])
    if customer
      render(
      json: customer.as_json(only: [:name, :registered_at, :address, :city, :state, :postal_code, :phone, :account_credit]), status: :ok )
    else
      render(
      json: {nothing: true}, status: :not_found
      )
    end
  end
  def create
  end
end
