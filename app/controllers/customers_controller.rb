class CustomersController < ApplicationController
  def index
    accepted_params = %w(name registered_at postal_code)
    if accepted_params.include?(params[:sort])
      customers = Customer.all.order(params[:sort].to_sym)
    else
      customers = Customer.all.order(:id)
    end
    if params[:n]
      customers = customers.paginate(:page => params[:p], :per_page => params[:n])
    end
    render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]), status: :ok
  end
end
