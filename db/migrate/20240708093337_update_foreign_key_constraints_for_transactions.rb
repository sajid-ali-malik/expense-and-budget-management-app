# frozen_string_literal: true

class UpdateForeignKeyConstraintsForTransactions < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :transactions, column: :source_account_id
    remove_foreign_key :transactions, column: :destination_account_id

    add_foreign_key :transactions, :accounts, column: :source_account_id, on_delete: :nullify
    add_foreign_key :transactions, :accounts, column: :destination_account_id, on_delete: :nullify
  end
end
