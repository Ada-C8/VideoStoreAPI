class RentalsController < ApplicationController
  def checkout
    # due_date = self.due_date
    due_date = (Date.today + 4.days)
    rental = Rental.new(rental_params)
    rental.save
  end

  def checkin
  end

  def overdue
  end


private

def rental_params

  # puts due_date
  params.require(:rental).permit(:movie_id, :customer_id, :due_date)
end


end
