class User < ApplicationRecord
  has_many :accounts

  enum gender: {male: 1, female: 2, other: 3}

end
