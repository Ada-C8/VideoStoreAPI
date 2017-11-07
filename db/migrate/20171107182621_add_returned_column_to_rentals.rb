class AddReturnedColumnToRentals < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :returned, :boolean, default: false
  end
end
