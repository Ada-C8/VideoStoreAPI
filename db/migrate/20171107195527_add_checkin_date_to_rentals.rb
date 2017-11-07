class AddCheckinDateToRentals < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :checkin_date, :string
  end
end
