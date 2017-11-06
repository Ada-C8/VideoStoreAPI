class CustomersController < ApplicationController

  def index
    customers = Customer.index_customers

    render(
      json: customers.to_json
    )
  end
end
