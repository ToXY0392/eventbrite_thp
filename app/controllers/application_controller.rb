class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_devise_params, if: :devise_controller?

  def set_locale
    I18n.locale = :fr
  end

  protected

  def configure_devise_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :description])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :description, :avatar])
  end
end