class ProductsController < ApplicationController

  def index

  end

  def show
    @product = Product.find_by_id(params[:id])
    @categories = Category.all
  end
end
