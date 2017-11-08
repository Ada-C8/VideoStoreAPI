class CustomersController < ApplicationController
  def index
    customers = Customer.all

    render(
      json: customers.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone, :account_credit, :movies_checked_out_count]),
      status: :ok
    )
  end

  def show
    customer = Customer.find_by(id: params[:id])
    if customer
      render(
        json: customer.as_json(only: [:name, :registered_at, :address, :city, :state, :postal_code, :phone, :account_credit, :movies_checked_out_count]),
        status: :ok
      )
    else
      render json: {nothing: true}, status: :not_found
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone, :account_credit, :movies_checked_out_count)
  end
end
