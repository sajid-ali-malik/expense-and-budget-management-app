class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :icon
      t.string :color
      t.integer :type

      t.timestamps
    end
  end
end
