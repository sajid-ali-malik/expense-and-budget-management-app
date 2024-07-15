class ChangeBudgetMonthTypeInBudgets < ActiveRecord::Migration[7.1]
  def change
    change_column :budgets, :budget_month, 'date USING budget_month::date', null: false
  end
end
