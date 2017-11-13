class AddDefaultInventoryToMovie < ActiveRecord::Migration[5.1]
  def change
    change_column :movies, :inventory, :integer, default: 0
  end
end
