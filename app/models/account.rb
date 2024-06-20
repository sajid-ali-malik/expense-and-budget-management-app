class Account < ApplicationRecord
  belongs_to :user
  has_many :outgoing_transactions, class_name: 'Transaction', foreign_key: 'source_account_id', dependent: :destroy
  has_many :incoming_transactions, class_name: 'Transaction', foreign_key: 'destination_account_id', dependent: :destroy

  validates :name, :account_type, :currency, presence: true
end
