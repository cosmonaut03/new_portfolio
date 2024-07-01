class ApplicationController < ActionController::Base
  before_action :require_login

  # bootStrapのflashメッセージに使用可能なキーを設定
  add_flash_types :success, :info, :warning, :danger

  private

  def not_authenticated
    redirect_to login_path
    flash[:danger] = 'ログインしてください'
  end
end
