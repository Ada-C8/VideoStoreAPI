class SetDefaultDueDate < ActiveRecord::Migration[5.1]
  def change
    change_column :rentals, :due_date, :date, :default => Date.today + 5
  end
end
