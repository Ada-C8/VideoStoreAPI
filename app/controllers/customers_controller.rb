class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers, status: :ok
  end

  def overdue
    # overdue_rentals = Rental.where("movie_id = ? AND customer_id = ?", movie.id, customer.id)
    # theoretical: has_overdue?
    customers_with_overdue= Customer.all.select {|customer| customer.has_overdue?}

    if customers_with_overdue.empty?
      return render json: { ok: true, message: "No customers with overdue items" }, status: :ok
    end

    overdue_customers_array = []

    customers_with_overdue.each do |customer|
      #helper method: Customer# find_overdue_rentals, which returns an array of overdues
      # build the hash
      overdue_customer_hash = {}

      overdue_customer_hash[:customer_id] = customer.id
      overdue_customer_hash[:customer_name] = customer.name
      overdue_customer_hash[:postal_code] = customer.postal_code

      overdue_rentals = customer.find_overdue_rentals

      overdue_customer_hash[:overdue_rentals] = build_overdue_array(overdue_rentals)

      overdue_customers_array << overdue_customer_hash
    end

    render json: overdue_customers_array.as_json, status: :ok

  end

  def query(sort: params[:sort], n: params[:n], p: params[:p])
    # sort: params[:sort], n: params[:n], p: params[:p]


    # if sort = not recognise
      # return error
    # end

    case sort
    when nil
      # Customer.all
    when "name"
      # Customer.sort_by(:name)
    when "registered_at"
      # Customer.sort_by(:registered_at)
    when "postal_code"
      # Customer.sort_by(:postal_code)
    end


  end
end
