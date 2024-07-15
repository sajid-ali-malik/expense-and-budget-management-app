# frozen_string_literal: true

class UpdateBudgetsAndTransactions < ActiveRecord::Migration[7.1]
  def change
    remove_column :budgets, :period, :string
    remove_column :budgets, :month, :integer
    remove_column :budgets, :year, :integer
    add_column :budgets, :budget_month, :date

    remove_column :transactions, :month, :integer
    remove_column :transactions, :year, :integer
    remove_column :transactions, :attachments, :string
  end
end
