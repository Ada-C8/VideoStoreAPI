class FixDefaultFormoviesCheckedOut < ActiveRecord::Migration[5.1]
  def change
    change_column :customers, :movies_checked_out, :integer, :default => 0
  end
end
