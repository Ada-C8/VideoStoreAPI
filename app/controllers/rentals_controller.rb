class RentalsController < ApplicationController
  def checkout
    # due_date = self.due_date
    # due_date = (Date.today + 4.days)
    puts "about to create the instance"
    rental = Rental.new(rental_params)
    puts "rental"
    puts rental
    puts rental.class
    puts rental.due_date
    puts "in the method now"
    puts rental_params
    if rental.save
      # success
      puts "save worked"
    else
      # failure
      puts "save didn't work: #{rental.errors.messages}"
    end
    puts "after the save #"
    puts rental
    puts rental.class
  end

  def checkin
  end

  def overdue
  end


private

def rental_params
  puts "Now i'm down here in the params"
  # puts rental_params
  # puts due_date
  params.require(:rental).permit(:movie_id, :customer_id, :due_date)
  # puts "Now i'm afer the require"
  # puts rental_params
end


end
