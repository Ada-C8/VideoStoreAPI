class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    rental.save
  end

  def checkin
  end

  def overdue
  end


private

def rental_params
  due_date = self.due_date
  # puts due_date
  params.require(:rental).permit(:movie_id, :customer_id, :due_date)
end



end
