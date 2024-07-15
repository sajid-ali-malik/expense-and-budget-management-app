# frozen_string_literal: true

class ChangeCategoryTable < ActiveRecord::Migration[7.1]
  def change
    change_column :categories, :name, :string, null: false
    remove_column :categories, :kind, :integer
    add_column    :categories, :type, :string
  end
end
