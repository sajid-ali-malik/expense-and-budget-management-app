# frozen_string_literal: true

class ModifyBalanceColumnToAccount < ActiveRecord::Migration[7.1]
  def change
    change_column :accounts, :balance, :integer, null: false
  end
end
