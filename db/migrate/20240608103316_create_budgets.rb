class CreateBudgets < ActiveRecord::Migration[7.1]
  def change
    create_table :budgets do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name, null: false
      t.decimal :amount, null: false, precision: 10, scale:2
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false


      t.timestamps
    end

    create_join_table :budgets, :categories
  end
end
