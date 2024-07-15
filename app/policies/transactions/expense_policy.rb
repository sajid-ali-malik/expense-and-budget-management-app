# frozen_string_literal: true

module Transactions
  class ExpensePolicy < ApplicationPolicy
    def show?
      user == record.user
    end

    def update?
      user == record.user
    end

    def destroy?
      user == record.user
    end

    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.where(user_id: user.id)
      end
    end
  end
end
