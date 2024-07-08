class DashboardsController < ApplicationController
  before_action :require_login, only: %i[index]
  def index
    @home_layouts = current_user.home_layouts.order(position: :asc)
    @home_layouts.each do |layout|
      layout.categories = layout.categories.order(position: :asc)

      layout.categories.each do |category|
        category.folders = category.folders.order(position: :asc)
      end
    end
  end
end
