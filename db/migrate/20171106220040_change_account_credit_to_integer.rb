class ChangeAccountCreditToInteger < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :account_credit
    add_column :customers, :account_credit, :integer 
  end
end
