# frozen_string_literal: true

class AddCategoryToBudget < ActiveRecord::Migration[7.1]
  def change
    add_column :budgets, :category_id, :bigint
    change_column :budgets, :amount, :integer
  end
end
