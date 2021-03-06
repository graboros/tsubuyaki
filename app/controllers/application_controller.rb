class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    root_path
  end

protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

private
  def set_user
    @user = User.find(params[:user_id])
  end

  def redirect_when_dm_is_not_mine
    unless @dm.users.include?(current_user)
      redirect_to dms_url, alert: "権限のないDMにアクセスされました"
    end
  end

  def message_params
    params.require(:dm_message).permit(:content)
  end
end
