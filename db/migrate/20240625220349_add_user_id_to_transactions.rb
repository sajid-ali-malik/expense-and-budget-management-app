class AddUserIdToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :user_id, :bigint
  end
end
