class ProductsController < ApplicationController

  def index
    @top_products = Product.all.limit(2)
    @products = Product.all
  end

  def show
    @product = Product.find_by_slug(params[:id])
    @categories = Category.all
  end
end
