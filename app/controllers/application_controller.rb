class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  MAX_OF_DISPLAY = 10

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: %i(name email remember_me)
    )
    devise_parameter_sanitizer.permit(
      :account_update, keys: %i(name email password)
    )
  end
end
