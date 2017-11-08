class ChangeDueDateTypeToStringRentals < ActiveRecord::Migration[5.1]
  def change
    change_column :rentals, :due_date, 'date USING CAST(due_date AS date)'
  end
end
