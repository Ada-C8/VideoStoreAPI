class RollbackDueDateDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:rentals, :due_date, nil)
  end
end
