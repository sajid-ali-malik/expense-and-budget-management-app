class ChangeTransactions < ActiveRecord::Migration[7.1]
  def change
       change_column :transactions, :type, :string
  end
end
