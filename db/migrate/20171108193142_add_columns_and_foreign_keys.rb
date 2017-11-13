class AddColumnsAndForeignKeys < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :due_date, :string
    add_reference :rentals, :customer, foreign_key: true
    add_reference :rentals, :movie, foreign_key: true
  end
end
