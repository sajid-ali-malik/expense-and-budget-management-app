class ChangeAccounts < ActiveRecord::Migration[7.1]
  def change
    change_table :accounts do |t|
      t.rename(:type, :nature_of_account)
  end
end
end
