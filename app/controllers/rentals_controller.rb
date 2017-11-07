class RentalsController < ApplicationController
  def index
    rentals = Rental.all
  end

  def create
    rental = Rental.new(movie_id: params[:movie], customer_id: params[:customer])
    movie = Movie.find_by(id: params[:movie])

    if movie.available?
      if rental.save
        render json: rental.as_json(only: [:id, :movie, :customer, :due_date]), status: :created
      else
        render json: {errors: rental.errors.messages}, status: :bad_request
      end
    else
      render json: {ok: false}, status: :bad_request
    end
  end

  def update
    rental = Rental.find_by(id: params[:id])

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
