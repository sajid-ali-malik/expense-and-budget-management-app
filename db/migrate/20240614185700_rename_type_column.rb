# frozen_string_literal: true

class RenameTypeColumn < ActiveRecord::Migration[7.1]
  change_table :accounts do |t|
    t.rename(:type, :account_type)
  end
end
