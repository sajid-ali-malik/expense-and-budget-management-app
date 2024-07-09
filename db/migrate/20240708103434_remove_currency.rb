# frozen_string_literal: true

class RemoveCurrency < ActiveRecord::Migration[7.1]
  def change
    remove_column :accounts, :currency
  end
end
