class CustomersController < ApplicationController
  # protect_from_forgery with: :null_session

  def index
    customers = Customer.all

    render(
      # json: customers.as_json(except: [:created_at, :updated_at]),
      json: customers,
      status: :ok
    )
  end

  def show
    customer = Customer.find_by(id: params[:id])
    if customer
      render(
        json: customer,
        # json: customer.as_json(except: [:created_at, :updated_at]),
        status: :ok
      )
    else
      render(
        json: {nothing: true}, status: :not_found
      )
    end
  end

  def create
    customer = Customer.new(customer_params)

    if customer.save
      render(
        json: {id: customer.id}, status: :ok
      )
    else
      render(
        json: {errors: customer.errors.messages}, status: :bad_request
      )
    end
  end

  def update
    customer = Customer.find_by(id: params[:id])
    if customer
      customer.update_attributes(customer_params)
      if customer.save
        render(
          json: customer.as_json(except: [:created_at, :updated_at]),
          status: :ok
        )
      else
        render(
          json: {errors: customer.errors.messages}, status: :bad_request
        )
      end
    else
      render(
        json: {nothing: true}, status: :not_found
      )
    end
  end

  private

  def customer_params
    params.permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone, :account_credit, :movies_checked_out_count)
  end
end
