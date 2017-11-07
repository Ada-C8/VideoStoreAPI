class UpdateRentalModel < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :checkin, :string, default: nil
    add_column :rentals, :checkout, :string, default: nil
  end

  def up
    change_column_default :rentals, :due_date, nil
  end
end
