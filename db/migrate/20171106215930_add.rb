class Add < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :account_credit, :float
  end
end
