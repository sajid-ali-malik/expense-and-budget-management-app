class Category < ApplicationRecord
  has_one :transaction_record, class_name: "Transaction"
  enum kind: {food: 0, travel: 1, grocery: 2}
end
