# frozen_string_literal: true

class DeletingCategories < ActiveRecord::Migration[7.1]
  def change
    remove_column :transactions, :category_id
    drop_table :categories
    drop_table :budgets_categories
  end
end
