# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user

  enum account_type: { cash: 'cash', current: 'current', saving: 'saving', investment: 'investment',
                       personal: 'personal' }

  validates :name, :account_type, :balance, presence: true
end
