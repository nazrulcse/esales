class ProductsController < ApplicationController

  def index
    @products
    if params[:search].present?
      @search = Sunspot.search(Product) do
        keywords params[:search]
      end
      @products = @search.results
    else
      @products = Product.where(product_type: 'product').limit(5)
    end
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    if params[:max_price].present?
        @products = @products.where("price BETWEEN ? AND ? ",params[:min_price], params[:max_price])
    end

    if params[:color].present?
      color  = params[:color].insert(0, '#')
      @top_products = Product.where(color: color).limit(2)
      @products = @products.where(color: color)
    end

    if params[:tag].present?
      @products = Product.tagged_with(params[:tag])
    end
      @categories = Product.where("product_type = ?", "product").group("category_id").count
  end

  def show
    @product = Product.find_by_slug(params[:id])
    @categories = Product.where("product_type = ?", "product").group("category_id").count
    @reviews = @product.reviews
  end

  def set_language
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

  def more
    @products = Product.limit(5).offset(params[:offset])
    respond_to do |format|
      format.js {render :layout => false}
    end
  end
end
