class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[index new create]
  def index
    @user = User.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.user_name = @user.email.split('@').first
    if @user.save
      # ログイン
      @user = login(params[:user][:email], params[:user][:password])
      # ユーザの初期データ作成
      HomeLayout.create_default_for_user(@user.id)
      Category.create_default_for_user(@user.id)

      flash[:success] = '登録が完了しました'
      render turbo_stream: turbo_stream.action(:redirect, dashboards_path)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
