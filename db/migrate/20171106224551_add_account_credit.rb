class AddAccountCredit < ActiveRecord::Migration[5.1]
  def change
    add_column( :customers, :account_credit, :string)
  end
end
