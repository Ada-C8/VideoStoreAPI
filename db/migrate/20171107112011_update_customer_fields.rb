class UpdateCustomerFields < ActiveRecord::Migration[5.1]
  def change
    change_column :customers, :name, :string, null: false
    change_column :customers, :registered_at, :string, null: false
    change_column :customers, :address, :string, null: false
    change_column :customers, :city, :string, null: false
    change_column :customers, :state, :string, null: false
    change_column :customers, :postal_code, :string, null: false
    change_column :customers, :phone, :string, null: false
  end
end
