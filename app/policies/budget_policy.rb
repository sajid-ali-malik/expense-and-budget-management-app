# frozen_string_literal: true

class BudgetPolicy < ApplicationPolicy
  attr_reader :user, :budget

  def initialize(user, budget)
    @user = user
    @budget = budget
  end

  def update?
    user == budget.user
  end

  def destroy?
    user == budget.user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
