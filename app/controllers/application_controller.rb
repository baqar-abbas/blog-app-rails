class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
  devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :name, :password, :password_confirmation, :posts_counter, :current_password)}
  devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :name, :password, :password_confirmation, :posts_counter, :current_password)}
  end
end
