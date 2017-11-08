class RentalsController < ApplicationController
  def index
    rentals = Rental.where('due_date < ?', Date.today).where(returned: false)

    render json: rentals, status: :ok
  end

  def create
    rental = Rental.new(movie_id: params[:movie], customer_id: params[:customer])
    movie = Movie.find_by(id: params[:movie])
    customer = Customer.find_by(id: params[:customer])

    # if movie doesn't exist
    unless movie
      render json: { errors: { id: "Movie id #{params[:movie]} not found" } }, status: :not_found
      return
    end

    # if customer doesn't exist
    unless customer
      render json: { errors: { id: "Customer id #{params[:customer]} not found" } }, status: :not_found
      return
    end

    # check if movie is available
    if  movie.available?
      if rental.save
        render json: rental.as_json(only: [:id, :movie, :customer, :due_date]), status: :created
      else
        render json: { errors: rental.errors.messages }, status: :bad_request
      end
    else
      render json: { errors: { inventory: "Movie #{movie.title} isn't available" } }, status: :bad_request
    end
  end

  def update
    rental = Rental.find_by(id: params[:id])

    unless rental
      render json: { errors: { id: "Rental id #{params[:id]} not found" } }, status: :not_found
      return
    end

    if rental.checkin
      render json: rental.as_json(except: [:created_at]), status: :ok
    else
      render json: {errors: rental.errors.messages}, status: :bad_request
    end
  end

  private

    # def rentals_params
    #   params.require(:rental).permit(:movie, :customer)
    # end
end
