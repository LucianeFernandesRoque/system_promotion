class ProductCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product_category, only: %i[show edit update destroy]

  def index
    @product_categories = ProductCategory.all
  end

  def new
    @product_category = ProductCategory.new
  end

  def edit; end

  def show; end

  def create
    @product_category = ProductCategory.new(product_category_params)
    if @product_category.save
      redirect_to @product_category
    else
      render :new
    end
  end

  def update
    if @product_category.update(product_category_params)
      redirect_to product_category_path(@product_category)
    else
      render :edit
    end
  end

  def destroy
    @product_category.destroy
    redirect_to product_categories_path
  end

  private

  def product_category_params
    params
      .require(:product_category)
      .permit(:name, :code)
  end

  def set_product_category
    @product_category = ProductCategory.find(params[:id])
  end
end
