# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def set_accounts_and_categories
    @accounts = current_user.accounts
    @categories = Category.all
  end

  def set_categories_and_months
    @categories = Category.all
    @next_12_months = (0..11).map { |i| Time.now.beginning_of_month + i.months }
  end

  def record_not_found
    flash[:alert] = 'The record you were looking for could not be found.'
    redirect_to root_path
  end
end
