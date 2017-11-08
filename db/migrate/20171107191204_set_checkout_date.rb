class SetCheckoutDate < ActiveRecord::Migration[5.1]
  def change
    remove_column :rentals, :checkout_date
    add_column :rentals, :checkout_date, :datetime, :default => DateTime.now
  end
end
