# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :type, presence: true

  include ByCategoryAndMonth
end
