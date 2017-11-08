class RentalsController < ApplicationController

  def check_out

    rental = Rental.new
    rental.customer_id = params[:customer_id]
    rental.movie_id = params[:movie_id]
    rental.save

    if rental.checkout(params[:movie_id], params[:customer_id])
<<<<<<< HEAD
=======
      # render json: Movie.find_by_id(params[:movie_id]), status: :created
>>>>>>> eb8034a1dffa355efdf33a25125ef3c3fdb01c3b
      render json: rental.as_json(only: [:id, :checkout_date, :due_date, :customer_id, :movie_id]), status: :created
    else
      render json: {ok: false, errors: "Exceeded available inventory!"}, status: :bad_request
    end
  end


  def check_in
    rental = Rental.find_by_id(params[:rental_id])
<<<<<<< HEAD
    if !rental
      render json: rental.as_json(errors: "Customer has not checked out this movie yet."), status: :bad_request
    elsif
      rental.save
      rental.checkin
=======
    rental.save
    if rental.checkin
>>>>>>> eb8034a1dffa355efdf33a25125ef3c3fdb01c3b
      render json: rental.as_json(only: [:id, :checkout_date, :due_date]), status: :created
    else
      render json: rental.as_json(errors: "Customer has not checked out this movie yet."), status: :bad_request
    end
  end

<<<<<<< HEAD
  def overdue(due_date)
    #     while due_date < today
    #       overdue is false
    #
    #     if today > due_date
    #       movie's due_date is < today
    #       movie that is in the rental
    #       return
    #     render json: rental.as_json(only: [:title, :customer_id, :name, :postal_code, :checkout_date, :due_date ]), status: :created
    # else
    #   return []
    # end
    #     List all customers with overdue movies
=======
  def overdue

  end

>>>>>>> eb8034a1dffa355efdf33a25125ef3c3fdb01c3b

  end
end
