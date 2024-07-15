# frozen_string_literal: true

class MajorChangesInSchema < ActiveRecord::Migration[7.1]
  def change
    remove_column :transactions, :label_id
    drop_table :labels
    remove_column :accounts, :color
    remove_column :budgets, :category_id
    change_column :budgets, :period, :string, default: '', null: false
    remove_column :transactions, :user_id
    remove_column :transactions, :category_id
  end
end
