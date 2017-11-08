class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers, status: :ok
  end

  def overdue
    # overdue_rentals = Rental.where("movie_id = ? AND customer_id = ?", movie.id, customer.id)
    # theoretical: has_overdue?
    customers_with_overdue= Customer.all.select(|customer| customer.has_overdue? )

    overdue_customers_hash = {}

    customers_with_overdue.each do |customer|
      #helper method: Customer# find_overdue_rentals, which returns an array of overdues
      # build the hash

    end

    render json: overdue_customers_hash.as_json, status: ok



  end
end
