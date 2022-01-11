class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: Rails.configuration.admin_login[:username], password: Rails.configuration.admin_login[:password]
  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    
    if @category.save
      redirect_to [:admin, :categories], notice: 'U dun made a new category!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end
end
