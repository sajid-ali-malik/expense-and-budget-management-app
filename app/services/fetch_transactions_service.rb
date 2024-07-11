class FetchTransactionsService
  def initialize(user, params)
    @user = user
    @params = params
    @sort_order = params[:sort] || 'desc'
  end

  def call
    transactions = @user.transactions.order(created_at: @sort_order).page(@params[:page]).per(5)
    transactions = filter_by_source_account(transactions)
    transactions = filter_by_destination_account(transactions)
    filter_by_type(transactions)
  end

  private

  def filter_by_source_account(transactions)
    return transactions unless @params[:source_account_id].present?

    transactions.where(source_account_id: @params[:source_account_id])
  end

  def filter_by_destination_account(transactions)
    return transactions unless @params[:destination_account_id].present?

    transactions.where(destination_account_id: @params[:destination_account_id])
  end

  def filter_by_type(transactions)
    return transactions unless @params[:type].present?

    transactions.where(type: @params[:type])
  end
end
