class ChangeBudget < ActiveRecord::Migration[7.1]
  def change
    change_table :budgets do |t|
      t.remove :start_date, :end_date, :category
    end
  end
end
