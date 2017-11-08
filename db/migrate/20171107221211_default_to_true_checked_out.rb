class DefaultToTrueCheckedOut < ActiveRecord::Migration[5.1]
  def change
    change_column :rentals, :checked_out, :boolean, default: true
  end
end
