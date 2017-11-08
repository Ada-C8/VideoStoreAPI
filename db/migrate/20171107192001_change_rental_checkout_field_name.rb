class ChangeRentalCheckoutFieldName < ActiveRecord::Migration[5.1]
  def change
    remove_column :rentals, :checkout
    add_column :rentals, :checkout_date, :string
  end
end
