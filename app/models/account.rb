class Account < ApplicationRecord
  belongs_to :user

  has_many :source_transactions, class_name: 'Transactions::Expense', foreign_key: 'source_account_id'
  has_many :income_transactions, class_name: 'Transactions::Income', foreign_key: 'destination_account_id'
  has_many :outgoing_transfers, class_name: 'Transactions::Transfer', foreign_key: 'source_account_id'
  has_many :incoming_transfers, class_name: 'Transactions::Transfer', foreign_key: 'destination_account_id'

  enum account_type: {cash: 'cash', current: 'current', saving:'saving',investment: 'investment', personal: 'personal'}

  validates :name, :account_type, :currency, :balance, presence: true
end
