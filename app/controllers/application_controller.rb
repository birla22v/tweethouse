class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_sign_up_params, if: :devise_controller?
  before_action :configure_update_params, if: :devise_controller?
  private
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :username << :private
  end
  def configure_update_params
    devise_parameter_sanitizer.for(:account_update) << :private
  end
end
