class AddingCheckedIn < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :check_in, :boolean, default: false
  end
end
