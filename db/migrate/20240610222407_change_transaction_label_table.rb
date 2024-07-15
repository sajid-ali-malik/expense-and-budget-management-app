# frozen_string_literal: true

class ChangeTransactionLabelTable < ActiveRecord::Migration[7.1]
  change_table :transactions do |t|
    t.belongs_to :label, foreign_key: true
  end
end
