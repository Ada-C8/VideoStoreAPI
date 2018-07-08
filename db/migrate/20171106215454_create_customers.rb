class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :registered_at
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :phone
      t.float :account_credit, default: 0.00
      t.timestamps
    end
  end
end
