# frozen_string_literal: true

class AddBalanceColumnToAccount < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :balance, :decimal, precision: 15, scale: 2, default: 0.0, null: false
  end
end
