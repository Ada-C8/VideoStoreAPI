class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.integer :movie_id
      t.integer :customer_id
      t.string :due_date
      t.timestamps
    end
    add_index :rentals, [:movie_id, :customer_id]
  end
end
