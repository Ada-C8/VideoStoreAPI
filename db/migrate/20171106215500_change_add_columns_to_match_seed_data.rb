class ChangeAddColumnsToMatchSeedData < ActiveRecord::Migration[5.1]
  def change
    rename_column :customers, :created_at, :registered_at
    add_column :customers, :account_credit, :decimal
  end
end
