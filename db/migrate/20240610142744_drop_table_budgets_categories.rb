# frozen_string_literal: true

class DropTableBudgetsCategories < ActiveRecord::Migration[7.1]
  def change
    drop_table :budgets_categories
  end
end
