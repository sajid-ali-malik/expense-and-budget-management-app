class AddValidationsToTables < ActiveRecord::Migration[7.1]
  def change
    change_column :accounts, :account_type, :string, null: false
    change_column :budgets, :category_id, :bigint, null: false
    change_column :budgets, :budget_month, :string, null: false
    change_column :transactions, :category_id, :bigint, null: false
    change_column :transactions, :user_id, :bigint, null: false
  end
end
