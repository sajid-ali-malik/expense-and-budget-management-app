class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :label


  validates :amount, presence: true
end
