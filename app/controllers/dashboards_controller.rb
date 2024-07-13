class DashboardsController < ApplicationController
  before_action :require_login, only: %i[index]

  def index
    @home_layouts = current_user.home_layouts.order(position: :asc)
    @home_layouts.each do |layout|
      # カテゴリ情報取得
      layout.categories = layout.categories.order(position: :asc)
      layout.categories.each do |category|
        # フォルダなしのブックマークを取得
        bookmarks_without_folder = category.bookmarks.where(folder_id: nil).order(position: :asc)
        bookmarks_without_folder.each(&:fetch_thumbnail)

        # フォルダ情報取得
        category.folders = category.folders.order(position: :asc)
        category.folders.each do |folder|
          # フォルダ内のブックマークを取得
          folder.bookmarks = folder.bookmarks.order(position: :asc)
          folder.bookmarks.each(&:fetch_thumbnail)
        end

        # フォルダなしのブックマークを格納する
        category.bookmarks_without_folder = bookmarks_without_folder
      end
    end
  end
end
