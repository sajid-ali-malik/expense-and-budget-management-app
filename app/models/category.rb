class Category < ApplicationRecord
  has_many :budgets
  has_many :expenses, class_name: 'Transactions::Expense', foreign_key: 'category_id'

  validates :name, presence: true
end
