class ProductsController < ApplicationController

  def index
    if params[:category].present?
      items = Product.where('product_type = ?', params[:category]).joins(:category).joins(:brand)
    else
      items = Product.all.joins(:category).joins(:brand)
    end

    if params[:search].present?
      items = items.where("products.name like '%#{params[:search]}%' or categories.name like '%#{params[:search]}%' or brands.name like '%#{params[:search]}%'")
    end

    if params[:category_id].present?
      items = items.where(category_id: params[:category_id])
    end

    if params[:max_price].present?
      items = items.where('price BETWEEN ? AND ?', params[:min_price], params[:max_price])
    end

    if params[:color].present?
      color = params[:color].insert(0, '#')
      items = items.where(color: color)
    end

    if params[:tag].present?
      items = Product.tagged_with(params[:tag])
    end

    @categories = items.group('category_id').count
    @products = items
    if params[:category] == 'service'
      render 'services'
    end
  end

  def show
    @product = Product.find_by_slug(params[:id])
    @categories = Product.where('product_type = ?', 'product').group('category_id').count
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
      format.js { render :layout => false }
    end
  end
end
