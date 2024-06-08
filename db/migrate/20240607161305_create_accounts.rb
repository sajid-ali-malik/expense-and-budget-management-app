class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :account_number
      t.integer :type, null: false
      t.string :currency, null: false
      t.string :color

      t.timestamps
    end
  end
end

