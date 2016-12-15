class ProductsController < ApplicationController

  def index
    items = Product.all.includes(:category).includes(:brand).limit(8)

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

    @categories = Product.group('category_id').count
    @products = items
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

  def review
    product = Product.find_by_slug(params["id"])
    product_review = product.reviews.build(user_id: current_user.id)
    product_review.comment = params["comment"]
    product_review.save
  end

  def more
    items = Product.all.includes(:category).includes(:brand).limit(5).offset(params[:offset])

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
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
end
