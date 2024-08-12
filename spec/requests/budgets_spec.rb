require 'rails_helper'

RSpec.describe 'Budgets', type: :request do
  include Devise::Test::IntegrationHelpers

  let!(:user) { create(:user, confirmed_at: Time.current) }
  let!(:category) { create(:category) }
  let!(:budget) { create(:budget, user:, category:) }

  before do
    sign_in user
  end

  describe 'GET /budgets' do
    it 'returns a list of budgets' do
      get budgets_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(budget.amount.to_s)
    end
  end

  describe 'GET /budgets/:id' do
    it 'returns the budget details' do
      get budget_path(budget)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(budget.amount.to_s)
    end
  end

  describe 'POST /budgets' do
    context 'with valid parameters' do
      it 'creates a new budget and redirects to budgets path' do
        expect do
          post budgets_path, params: {
            budget: {
              category_id: category.id,
              budget_month: Date.current.next_month.beginning_of_month,
              amount: 1000
            }
          }
        end.to change(Budget, :count).by(1)
        expect(response).to redirect_to(budgets_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new budget and renders the new page' do
        expect do
          post budgets_path, params: {
            budget: {
              category_id: nil,
              budget_month: nil,
              amount: 1000
            }
          }
        end.not_to change(Budget, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH /budgets/:id' do
    it 'updates the budget and redirects to budgets path' do
      patch budget_path(budget), params: {
        budget: { amount: 2000 }
      }
      budget.reload
      expect(budget.amount).to eq(2000)
      expect(response).to redirect_to(budgets_path)
    end
  end

  describe 'DELETE /budgets/:id' do
    it 'deletes the budget and redirects to budgets path' do
      expect do
        delete budget_path(budget)
      end.to change(Budget, :count).by(-1)
      expect(response).to redirect_to(budgets_path)
    end
  end
end
