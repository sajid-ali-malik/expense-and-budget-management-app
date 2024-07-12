# frozen_string_literal: true

class Budget < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :name, :budget_month, presence: true
end
