class AddForeignKeysToRentalsModel < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :rentals, :movies
    add_foreign_key :rentals, :customers
  end
end
