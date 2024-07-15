# frozen_string_literal: true

class TransactionPolicy < ApplicationPolicy
  attr_reader :user, :transaction

  def initialize(user, transaction)
    @user = user
    @transaction = transaction
  end

  def update?
    user == transaction.user
  end

  def destroy?
    user == transaction.user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
