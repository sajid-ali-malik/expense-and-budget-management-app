require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  include Devise::Test::IntegrationHelpers

  let!(:user) { create(:user, confirmed_at: Time.current) }
  let!(:account) { create(:account, user:) }

  before do
    sign_in user
  end

  describe 'GET /accounts' do
    it 'returns a list of accounts' do
      get accounts_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(account.name)
    end
  end

  describe 'GET /accounts/:id' do
    it 'returns the account details' do
      get account_path(account)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(account.name)
    end
  end

  describe 'POST /accounts' do
    context 'with valid parameters' do
      it 'creates a new account and redirects to accounts path' do
        expect do
          post accounts_path, params: {
            account: {
              name: 'New Account',
              account_type: 'cash',
              balance: 500
            }
          }
        end.to change(Account, :count).by(1)
        expect(response).to redirect_to(accounts_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new account and renders the new page' do
        expect do
          post accounts_path, params: {
            account: {
              name: '',
              account_type: '',
              balance: 500
            }
          }
        end.not_to change(Account, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH /accounts/:id' do
    context 'with valid parameters' do
      it 'updates the account and redirects to accounts path' do
        patch account_path(account), params: {
          account: { name: 'Updated Account Name' }
        }
        account.reload
        expect(account.name).to eq('Updated Account Name')
        expect(response).to redirect_to(accounts_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the account and renders the edit page' do
        patch account_path(account), params: {
          account: { account_type: '' }
        }
        account.reload
        expect(account.account_type).not_to eq('')
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /accounts/:id' do
    it 'deletes the account and redirects to root path' do
      delete account_path(account)
      expect(Account.exists?(account.id)).to be(false)
      expect(response).to redirect_to(root_path)
    end
  end
end
