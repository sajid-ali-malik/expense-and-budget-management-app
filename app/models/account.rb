class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  enum nature_of_account: {cash: 0, current: 1, saving: 2, investment: 3, personal: 4}

  validates :name, :nature_of_account, :currency, presence: true

end
