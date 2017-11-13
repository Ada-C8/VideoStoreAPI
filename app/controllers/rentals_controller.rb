class RentalsController < ApplicationController
  before_action :rental_exists, only: :checkin
  def checkout
    rental = Rental.new(rental_params)
    if rental.save
      render(
        json:{id: rental.id, due_date: rental.due_date},
        status: :ok
      )
    else
      render(
        json: {errors: rental.errors.messages},
        status: :bad_request
      )
    end
  end

  def checkin
    @rental.due_date = nil
    if @rental.save
      render(
        json:{customer_id: @rental.customer_id, movie_id: @rental.movie_id,
          status: :ok
        }
      )
      else
        render(
          json: {errors: @rental.errors.messages},
          status: :bad_request
        )
      end
    end

    protected
    def rental_exists
      @rental = Rental.find_by(id: params[:id])
      unless @rental
        render(
          json: {nothing: true},
          status: :not_found
        )
      end
    end

    private
    def rental_params
      params.require(:rental).permit(:movie_id, :customer_id, :checkout_date, :due_date)
    end
  end
