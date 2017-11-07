class RentalsController < ApplicationController
  def checkout
    # due_date = self.due_date
    # due_date = (Date.today + 4.days)
    rental = Rental.new(rental_params)

    if rental.save
      # success
      puts "save worked"
    else
      # failure
      puts "save didn't work: #{rental.errors.messages}"
    end
  end

  def checkin
  end

  def overdue
  end


private

def rental_params
  params.require(:rental).permit(:movie_id, :customer_id, :due_date)
end


end
