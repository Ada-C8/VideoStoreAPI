class AddCheckinOutDateToRental < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :checkout_date, :date
    add_column :rentals, :returned, :boolean, default: false
  end
end
