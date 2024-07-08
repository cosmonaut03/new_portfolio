class FoldersController < ApplicationController
  before_action :require_login

  def new
    @folder = Folder.new
    @category_id = params[:category_id]
  end

  def create
    @folder = Folder.new(folder_params)
    @folder.user_id = current_user.id
    @folder.position = Folder.get_new_position_folder(@folder.category_id)

    return if @folder.save

    render :new, status: :unprocessable_entity
  end

  def edit
    set_folder
    @category_id = @folder.category_id
  end

  def update
    set_folder
    return if @folder.update(folder_params)

    render :edit, status: :unprocessable_entity
  end

  def destroy
    set_folder
    @folder.destroy!
  end

  def show
    @folder = Folder.new
  end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:name, :description, :category_id)
  end
end
