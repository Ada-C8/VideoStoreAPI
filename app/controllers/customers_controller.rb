class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(except: :updated_at), status: :ok
  end
end
