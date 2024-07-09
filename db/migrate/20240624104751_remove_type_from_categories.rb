# frozen_string_literal: true

class RemoveTypeFromCategories < ActiveRecord::Migration[7.1]
  def change
    remove_column :categories, :type
  end
end
