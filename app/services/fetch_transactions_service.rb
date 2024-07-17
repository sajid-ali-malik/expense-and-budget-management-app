class FetchTransactionsService
  def initialize(user, params)
    @user = user
    @params = params
    @sort_order = params[:sort] || 'desc'
  end

  def call
    filter_conditions = {
      source_account_id: @params[:source_account_id].presence,
      destination_account_id: @params[:destination_account_id].presence,
      category_id: @params[:category_id].presence,
      type: @params[:type].presence
    }.compact

    @user.transactions.where(filter_conditions).order(created_at: @sort_order).page(@params[:page]).per(20)
  end
end
