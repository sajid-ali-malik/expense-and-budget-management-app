class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :account_number
      t.integer :type
      t.string :currency
      t.string :color

      t.timestamps
    end
  end
end
