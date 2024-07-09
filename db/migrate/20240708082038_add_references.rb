# frozen_string_literal: true

class AddReferences < ActiveRecord::Migration[7.1]
  def change
    add_reference :transactions, :category, foreign_key: { to_table: :categories }
    add_reference :transactions, :user, foreign_key: { to_table: :users }
    add_reference :budgets, :category, foreign_key: { to_table: :categories }
  end
end
