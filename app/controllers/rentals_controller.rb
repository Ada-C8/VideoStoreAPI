class RentalsController < ApplicationController

  def checkin
    rental = Rental.where("customer_id = ? and movie_id = ?", params[:customer_id], params[:movie_id])[0]
    if rental
      rental.customer.movies_checked_out_count -= 1
      rental.movie.available_inventory += 1
      unless rental.customer.save && rental.movie.save
        render json: {errors: {customer: customer.errors.messages, movie: movie.errors.messages} }, status: :bad_request
      end
      render json: rental.as_json(only: [:customer_id, :movie_id])
      rental.destroy
    else
      render json: {errors: "rental not found" }, status: :not_found
    end
  end

  def checkout
    rental = Rental.new rental_params
    rental.due_date = (Date.today() + 4).to_s
    if rental.save
      customer = Customer.find_by(id: params[:customer_id])
      customer.movies_checked_out_count += 1

      movie = Movie.find_by(id: params[:movie_id])
      movie.available_inventory -= 1

      if customer.save && movie.save
        render json: rental.as_json(only: [:customer_id, :movie_id, :due_date])
      else
        render json: {errors: {customer: customer.errors.messages, movie: movie.errors.messages} }, status: :bad_request
      end
    else
      render json: {errors: rental.errors.messages}, status: :bad_request
    end
  end

  def overdue
    accepted_params = %w(title name checkout_date due_date)
    if accepted_params.include?(params[:sort])
      if params[:sort] == 'title'
        rentals = Rental.joins(:movie).order("movies.title").where("due_date < ?", Date.today())
      elsif params[:sort] == 'name'
        rentals = Rental.joins(:customer).order("customers.name").where("due_date < ?", Date.today())
      elsif params[:sort] == 'checkout_date'
        rentals = Rental.joins(:movie).joins(:customer).where("due_date < ?", Date.today()).order(:created_at)
      else
        rentals = Rental.joins(:movie).joins(:customer).where("due_date < ?", Date.today()).order(:due_date)
      end
    else
      rentals = Rental.where("due_date < ?", Date.today())
    end
    if params[:n]
      rentals = rentals.paginate(:page => params[:p], :per_page => params[:n])
    end
    render json: rentals, status: :ok
  end

  private
  def rental_params
    params.permit(:customer_id, :movie_id)
  end

  def customer_params
    params.permit(:customer_id)
  end

  def movie_params
    params.permit(:movie_id)
  end
end
