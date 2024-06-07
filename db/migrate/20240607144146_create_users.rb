class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :image
      t.date :dob
      t.integer :gender

      t.timestamps
    end

    add_index :users, :email, unique: true

  end

end
