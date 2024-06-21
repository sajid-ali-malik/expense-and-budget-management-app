class ChangeGenderColumn < ActiveRecord::Migration[7.1]
 change_column :users, :gender, :string
end
