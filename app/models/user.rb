class User < ApplicationRecord
  has_many :accounts, dependent: :destroy
  has_many :budgets, dependent: :destroy

  enum gender: {male: 1, female: 2, other: 3}

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

end
