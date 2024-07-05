class AddCategoryToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :category_id, :bigint
  end
end
