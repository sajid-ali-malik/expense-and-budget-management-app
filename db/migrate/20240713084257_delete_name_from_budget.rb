# frozen_string_literal: true

class DeleteNameFromBudget < ActiveRecord::Migration[7.1]
  def change
    remove_column :budgets, :name
  end
end
