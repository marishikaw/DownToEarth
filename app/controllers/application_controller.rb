class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  
  # ログイン・ログアウト時のパスを初期値から変更
  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  # プライベートメソッド--------------------------------------  
  protected
	
  #サインアップ時にユーザー名を渡す
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end