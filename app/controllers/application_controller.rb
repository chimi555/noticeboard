class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
  MAX_OF_DISPLAY = 10

  def set_search
    @search = Topic.ransack(params[:q])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: %i(name email remember_me)
    )
    devise_parameter_sanitizer.permit(
      :account_update, keys: %i(name email password)
    )
  end

  def test_user
    return unless current_user.test?
    flash[:info] = '申し訳ありません。テストユーザーは編集できません。'
    redirect_to user_path(current_user.id)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
