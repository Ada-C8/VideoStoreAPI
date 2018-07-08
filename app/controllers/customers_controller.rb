class CustomersController < ApplicationController

  def index
    customers = Customer.all
    render(
    :json => customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]), status: :ok
    )
  end

  def show
    customer = Customer.find_by(id: params[:id])

    if customer
      render(
      json: customer.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone]),
      status: :ok
      )
    else
      render(
      json: {id: "Invalid Customer ID"},
      status: :not_found
      )
    end
  end

  def create
    customer = Customer.new(customer_params)

    if customer.save
      render(
      json: {id: customer.id},
      status: :ok
      )
    else
      render(
      json: {errors: customer.errors.messages}, status: :bad_request
      )
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone)
  end

end
