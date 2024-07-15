# frozen_string_literal: true

class AddMonthAndYearToTransactionsAndBudgets < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :month, :integer
    add_column :transactions, :year, :integer
    add_column :budgets, :month, :integer
    add_column :budgets, :year, :integer

    add_index :transactions, :month
    add_index :transactions, :year
    add_index :budgets, :month
    add_index :budgets, :year
  end
end
