class User < ApplicationRecord
  has_many :accounts, dependent: :destroy
  has_many :budgets, dependent: :destroy

  enum gender: {male: 'male', female: 'female', other: 'other'}

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

end
