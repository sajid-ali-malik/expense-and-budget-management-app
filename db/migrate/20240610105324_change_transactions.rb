class ChangeTransactions < ActiveRecord::Migration[7.1]
  def change
      remove_column :transactions, :account_id, :bigint
  end
end
