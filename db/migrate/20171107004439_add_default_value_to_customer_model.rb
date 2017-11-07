class AddDefaultValueToCustomerModel < ActiveRecord::Migration[5.1]
  def up
    change_column_default :customers, :movies_checked_out_count, 0
  end

  def down
    change_column_default :customers, :movies_checked_out_count, nil
  end
end
