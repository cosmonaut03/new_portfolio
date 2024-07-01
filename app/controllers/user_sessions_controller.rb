class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      flash[:success] = 'ログインしました'
      render turbo_stream: turbo_stream.action(:redirect, root_path)
    else
      @user = User.new # エラーを保持するための新しいユーザーオブジェクトを作成
      @user.errors.add(:base, 'メールアドレスまたはパスワードが無効です') # カスタムエラーメッセージを追加
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, success: 'ログアウトしました'
  end
end
