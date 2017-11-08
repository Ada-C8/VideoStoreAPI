class ChangeRentalsDataForCheckoutDateDueDateCheckinDate < ActiveRecord::Migration[5.1]
  def change
    change_column :rentals, :checkout_date, 'date USING CAST(checkout_date AS date)'
    change_column :rentals, :due_date, 'date USING CAST(due_date AS date)'
    change_column :rentals, :checkin_date, 'date USING CAST(checkin_date AS date)'
  end
end
