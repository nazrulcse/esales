class ProductsController < ApplicationController

  def index
    @search = Sunspot.search(Product) do
      keywords params[:search]
    end
    @products = @search.results
    @top_products = Product.limit(2)
    @categories = Category.all
    if params[:category_id].present?
      @top_products = Product.all.where(category_id: params[:category_id]).limit(2)
      @products = @products.where(category_id: params[:category_id])
    end

    if params[:max_price].present?
        @products = @products.where("price BETWEEN ? AND ? ",params[:min_price], params[:max_price])
        @top_products = Product.where("price BETWEEN ? AND ? ",params[:min_price], params[:max_price]).limit(2)
    end

    if params[:color].present?
      color  = params[:color].insert(0, '#')
      @top_products = Product.where(color: color).limit(2)
      @products = @products.where(color: color)
    end
  end

  def show
    @product = Product.find_by_slug(params[:id])
    @categories = Category.all
  end

  def set_locale
    session[:locale] = params[:locale]
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def review_product
    product_review = current_user.reviews.find_or_initialize_by(product_id: params["product_id"])
    product_review.rating = params["rating"]
    product_review.comment = params["comment"]
    product_review.save
  end
end
