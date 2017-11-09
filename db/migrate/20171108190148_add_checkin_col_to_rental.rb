class AddCheckinColToRental < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :check_in, :string
  end
end
