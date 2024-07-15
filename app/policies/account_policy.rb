# frozen_string_literal: true

class AccountPolicy
  attr_reader :user, :account

  def initialize(user, account)
    @user = user
    @account = account
  end

  def update?
    user == account.user
  end

  def destroy?
    user == account.user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
