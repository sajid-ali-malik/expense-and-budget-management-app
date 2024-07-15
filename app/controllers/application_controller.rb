# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def user_not_authorized
    flash[:alert] = 'Sorry, You are not authorized to perform this action.'
    redirect_to(root_path)
  end

  def record_not_found
    flash[:alert] = 'The record you were looking for could not be found.'
    redirect_to root_path
  end
end
