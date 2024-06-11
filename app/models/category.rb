class Category < ApplicationRecord
  has_many :transaction_record, class_name: "Transaction"

  validates :name, presence: false
end
