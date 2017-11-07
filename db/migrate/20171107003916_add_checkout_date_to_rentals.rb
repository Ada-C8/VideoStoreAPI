class AddCheckoutDateToRentals < ActiveRecord::Migration[5.1]

  def change
    add_column :rentals, :checkout_date, :string
  end

end
