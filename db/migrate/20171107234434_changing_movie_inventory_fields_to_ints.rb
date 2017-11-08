class ChangingMovieInventoryFieldsToInts < ActiveRecord::Migration[5.1]
  def change
    remove_column :movies, :inventory
    remove_column :movies, :available_inventory
    remove_column :customers, :account_credit

    add_column :movies, :inventory, :integer
    add_column :movies, :available_inventory, :integer
    add_column :customers, :account_credit, :float
  end
end
