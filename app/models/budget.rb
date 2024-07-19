# frozen_string_literal: true

class Budget < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :amount, presence: true
  validates :budget_month, presence: true
  validate :unique_budget_per_month

  def spent_amount
    Transaction.by_category_and_month(user, category_id, budget_month).sum(:amount)
  end

  private

  def unique_budget_per_month
    existing_budget = Budget.find_by(category:, budget_month:, user:)
    return unless existing_budget

    errors.add(:base, 'The budget already exists for this category and month. Please edit the existing budget.')
  end
end
