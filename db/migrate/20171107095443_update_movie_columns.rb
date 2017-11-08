class UpdateMovieColumns < ActiveRecord::Migration[5.1]
  def change
    change_column :movies, :title, :string, null: false
    change_column :movies, :release_date, :string, null: false
    change_column :movies, :overview, :string, null: false
    change_column :movies, :inventory, :string, default: 0, null: false
    change_column :movies, :available_inventory, :string, default: 0, null: false
  end
end
