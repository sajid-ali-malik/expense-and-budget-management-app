class RemoveValidationFromTransactioinForCategoryId < ActiveRecord::Migration[7.1]
  def change
    change_column :transactions, :category_id, :bigint
  end
end
