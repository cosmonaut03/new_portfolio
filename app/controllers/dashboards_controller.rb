class DashboardsController < ApplicationController
  before_action :require_login, only: %i[index]
  def index
    @home_layouts = HomeLayout.all.where(user_id: current_user.id)
  end
end
