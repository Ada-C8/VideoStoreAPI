require 'date'
class RentalsController < ApplicationController

  def check_out

    rental = Rental.new
    rental.customer_id = params[:customer_id]
    rental.movie_id = params[:movie_id]
    rental.save

    if rental.checkout(params[:movie_id], params[:customer_id])

      render json: rental.as_json(only: [:id, :checkout_date, :due_date, :customer_id, :movie_id]), status: :created
    else
      render json: {ok: false, errors: "Exceeded available inventory!"}, status: :bad_request
    end
  end


  def check_in
    rental = Rental.find_by(id: params[:rental_id])
    if rental == nil
      render json: {ok: false, errors: "This rental does not exist"}, status: :bad_request
    else
      rental.save
      rental.checkin
      if rental.checkin
        render json: rental.as_json(only: [:id, :checkout_date, :due_date, :customer_id, :movie_id]), status: :created
      else
        render json: {ok: false, errors: "Customer has not checked out this movie yet."}, status: :bad_request
      end
    end
  end

  def overdue
    if Rental.find_overdue.count != 0
      Rental.find_overdue.each do |rental|
        render json: {
          "title" => Movie.find_by_id(rental.movie_id).title, "customer_id" => rental.customer_id, "name" => Customer.find_by_id(rental.customer_id).name, "postal_code" => Customer.find_by_id(rental.customer_id).postal_code, "checkout_date" => rental.checkout_date, "due_date" => rental.due_date
          },
          status: :ok
      end
    else
      render json: {ok: false, errors: "There are no overdue rentals to show."}, status: :no_content
    end
  end
end
