class ProductsController < ApplicationController

  def index
    @top_products = Product.all.limit(2)
    @products = Product.all
  end

  def show
    @product = Product.find_by_slug(params[:id])
    @categories = Category.all
  end

  def review_product
    product_review = current_user.reviews.find_or_initialize_by(product_id: params["product_id"])
    product_review.rating = params["rating"]
    product_review.comment = params["comment"]
    product_review.save
  end
end
