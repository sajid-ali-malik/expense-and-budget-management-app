# frozen_string_literal: true

class ChangeColumnAccount < ActiveRecord::Migration[7.1]
  def change
    remove_column :accounts, :nature_of_account
    add_column :accounts, :type, :string
  end
end
