class Budget < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :amount, presence: true
  validates :category_id, presence: true
  validates :budget_month, presence: true
  validate :unique_budget_per_month

  private

  def unique_budget_per_month
    existing_budget = user.budgets.where(category_id:, budget_month:).where.not(id:).exists?
    return unless existing_budget

    errors.add(:base, 'The budget already exists for this category and month. Please edit the existing budget.')
  end
end
