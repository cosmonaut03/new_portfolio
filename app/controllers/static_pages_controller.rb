class StaticPagesController < ApplicationController
  skip_before_action :require_login
  def top
    @user = User.new
  end
end
