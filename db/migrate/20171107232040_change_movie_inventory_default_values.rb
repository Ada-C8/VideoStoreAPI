class ChangeMovieInventoryDefaultValues < ActiveRecord::Migration[5.1]

  def up
    change_column_default :movies, :inventory, 0
    change_column_default :movies, :available_inventory, 0
  end
  
end
