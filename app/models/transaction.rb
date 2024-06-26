class Transaction < ApplicationRecord
  belongs_to :label
  belongs_to :user

  validates :amount, presence: true
  validates :type, presence: true
end
