class ChangeColumnMoviesOutDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :movies, :out, 0
  end
end
