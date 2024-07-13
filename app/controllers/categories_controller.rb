class CategoriesController < ApplicationController
  before_action :require_login

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    @category.position = Category.get_new_position_for_user(@category.user_id)

    return if @category.save

    render :new, status: :unprocessable_entity
  end

  def edit
    set_category
  end

  def update
    set_category
    return if @category.update(category_params)

    render :edit, status: :unprocessable_entity
  end

  def destroy
    set_category
    @category.destroy!
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
