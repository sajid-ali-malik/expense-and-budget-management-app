class RemoveNullValidationFromTransactioinForCategoryId < ActiveRecord::Migration[7.1]
  def change
    change_column :transactions, :category_id, :bigint, null: true
  end
end
