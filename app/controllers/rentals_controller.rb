class RentalsController < ApplicationController

  # This method is used to 'check-out' a movie.
  # A new instance of Rental is created using a customer_id and movie_id passed in by the user
  # This instance of Rental's checked_out status defaults to true
  def create
    rental = Rental.new(rental_data)
    rental.due_date = Date.today + 3
    if rental.save
      render(
        json: {id: rental.id, customer_id: rental.customer.id, movie_id: rental.movie.id, due_date: rental.due_date}
      )
    # if the user did not pass in valid information (i.e. there was no customer_id or movie_id) then the new instance of Rental will not save
    else
      render(
        json: {error: rental.errors.messages}, status: :bad_request
      )
    end # if/else
  end # create

  # the update method is used to 'check-in' a movie. It changes the checked_out attribute for the rental to false
  def update
    rental = Rental.find_by(id: params[:id])
    if rental
      rental.checked_out = false
      if rental.save
        render(
          json: {"checked_in" => true}, status: :ok
        )
      else
        render(
          json: {error: rental.errors.messages}, status: :bad_request
        )
      end # if/else
    # if the rental_id passed in does not exist then not_found is returned
    else
      render(
        json: {"no rental found": true}, status: :not_found
      )
    end # if rental
  end # update

  private
  def rental_data
    params.require(:rental).permit(:customer_id, :movie_id)
  end # rental_data
end
