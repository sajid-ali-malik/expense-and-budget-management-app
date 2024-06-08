class TransferTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :table_name do |t|
      t.integer :source_account, null: false
      t.integer :destination_account, null: false

      t.timestamps
    end

  end
end
