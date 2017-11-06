class CustomersController < ApplicationController
  def index
    customers = Customer.all
    # render(
    #   json: customers.as_json(only: [:name, :address, :registered_at, :city, :state, :postal_code, :phone, :account_credit]), status: :ok
    # )
    render(
      json: customers.as_json(except: [:created_at, :updated_at]),
      status: :ok
    )
  end

  # def show
  # end
  #
  # def create
  # end
  #
  # def update
  # end
end
