class CustomersController < ApplicationController
  def index
    customers = Customer.all

    render json: { message: 'hey yall!'}
  end
end
