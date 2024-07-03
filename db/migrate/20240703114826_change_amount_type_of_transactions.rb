class ChangeAmountTypeOfTransactions < ActiveRecord::Migration[7.1]
  def change
    change_column :transactions, :amount, :integer
  end
end
