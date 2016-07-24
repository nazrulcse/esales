class ServicesController < ApplicationController
  def index
    @services = Product.where(product_type: 'service').limit(1)
    if params[:category_id].present?
      @services = @services.where(category_id: params[:category_id])
    end

    if params[:tag].present?
      @services = Product.tagged_with(params[:tag],product_type: 'service')
    end
    @categories = Product.where("product_type = ?", "service").group("category_id").count
  end


  def show
    @product = Product.find_by_slug(params[:id])
    @categories = Product.where("product_type = ?", "service").group("category_id").count
    @reviews = @product.reviews
  end
end
