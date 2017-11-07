class CustomersController < ApplicationController

  def index
    customers = Customer.all
    render json: customers,
    status: :ok
  end

  def show
    customer = Customer.find_by_id(params[:id])
    if customer
      render json: customer, status: :ok
    else
      render json: {ok: false}, status: :not_found
    end
  end

end
