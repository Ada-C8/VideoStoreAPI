class AddColumnMoviesOut < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :out, :integer
  end
end
