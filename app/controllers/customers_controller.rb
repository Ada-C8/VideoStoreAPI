class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(only: [:id, :account_credit, :address, :city, :name, :phone, :postal_code, :registered_at, :state], :methods => [:movies_checked_out_count])
  end
end
