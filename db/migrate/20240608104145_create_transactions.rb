class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :category, foreign_key: true
      t.descimal :amount, null: false, precision:10, scale:2
      t.integer :type, null: false
      t.text :description
      t.string :attachments
      t.string :location
      t.string :labels

      t.timestamps
    end
  end
end
