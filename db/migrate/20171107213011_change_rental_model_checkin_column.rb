class ChangeRentalModelCheckinColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :rentals, :checkin
    add_column :rentals, :checkin_date, :string
  end
end
