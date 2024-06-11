class Budget < ApplicationRecord
  belongs_to :user

  validates :name, :start_date, :end_date, :amount, presence: true
end
