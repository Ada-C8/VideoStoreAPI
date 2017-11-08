class CustomersController < ApplicationController
# this action returns information for all of the customers in the api request
def index
  customers = Customer.all
  # render json: customers, status: :ok
  render(
    json: customers.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone], methods: [ :movies_checked_out_count])
  )
end
end
