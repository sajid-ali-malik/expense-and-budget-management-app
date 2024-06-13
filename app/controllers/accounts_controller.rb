class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = current_user.accounts
  end

  def show
  end

   def new
    @account = current_user.accounts.build(type: params[:type])
  end


  def create
    @account = current_user.accounts.build(account_params)
    if @account.save
      redirect_to accounts_path, notice: 'created'
    else
      render :new
    end
  end

  def edit
      @account = current_user.accounts.find(params[:id])
  end

  # def update
  #   if @account.update(account_params)
  #     redirect_to accounts_path, notice: ' updated'
  #   else
  #     render :edit
  #   end
  # end

  def update
    @account = current_user.accounts.find(params[:id])

    if @article.update(article_params)
      redirect_to @accounts_path, noice: "updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @account = current_user.accounts.find(params[:id])
    @account.destroy
    redirect_to accounts_path, notice: 'Deleted.'
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :account_number, :type, :currency, :color)
  end
end
