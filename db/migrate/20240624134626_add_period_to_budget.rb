# frozen_string_literal: true

class AddPeriodToBudget < ActiveRecord::Migration[7.1]
  def change
    add_column :budgets, :period, :string, null: false, default: 'custom'
  end
end
