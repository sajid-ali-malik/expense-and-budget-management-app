# frozen_string_literal: true

class DropTableName < ActiveRecord::Migration[7.1]
  def change
    drop_table :table_name
  end
end
