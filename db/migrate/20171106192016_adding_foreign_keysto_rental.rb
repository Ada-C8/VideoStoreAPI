class AddingForeignKeystoRental < ActiveRecord::Migration[5.1]
  def change
    add_reference :rentals, :movie, foreign_keys: true
    add_reference :rentals, :customer, foreign_keys: true

  end
end
