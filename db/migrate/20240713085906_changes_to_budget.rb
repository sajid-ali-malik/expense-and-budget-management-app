class ChangesToBudget < ActiveRecord::Migration[7.1]
  def change
    add_column :budgets, :notes, :text
    remove_column :users, :image
    remove_column :users, :dob
    remove_column :users, :gender
  end
end
