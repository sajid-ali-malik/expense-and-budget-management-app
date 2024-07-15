# frozen_string_literal: true

class ChangeCategories < ActiveRecord::Migration[7.1]
  def change
    change_table :categories do |t|
      t.rename(:type, :kind)
    end
  end
end
