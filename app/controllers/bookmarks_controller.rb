class BookmarksController < ApplicationController
  before_action :require_login

  def new
    @bookmark = Bookmark.new
    @category_id = params[:category_id]
    @folder_id = params[:folder_id]
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user_id = current_user.id
    @bookmark.position = Bookmark.get_new_position_bookmark(@bookmark)
    if @bookmark.save
      @bookmark.fetch_thumbnail
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    set_bookmark
    @category_id = @bookmark.category_id
    @folder_id = @bookmark.folder_id
  end

  def update
    set_bookmark
    if @bookmark.update(bookmark_params)
      @bookmark.fetch_thumbnail
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_bookmark
    @bookmark.destroy
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url, :title, :description, :category_id, :folder_id)
  end
end
