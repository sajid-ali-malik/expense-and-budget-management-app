# frozen_string_literal: true

class AddBudgetCategory < ActiveRecord::Migration[7.1]
  def change
    add_column :budgets, :category, :string
  end
end
