class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.integer :customer_id, null: false
      t.integer :movie_id, null: false
      t.date :due_date, null: false
      t.date :checkout_date, null: false
    end
      add_foreign_key :rentals, :customers
      add_foreign_key :rentals, :movies
  end
end
