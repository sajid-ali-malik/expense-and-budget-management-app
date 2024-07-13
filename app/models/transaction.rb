# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :type, presence: true

  scope :by_category_and_month, lambda { |user, category_id, budget_month|
    where(user:)
      .where(category_id:)
      .where('DATE(created_at) = ?', budget_month)
  }
end
