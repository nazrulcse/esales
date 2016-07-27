class ProductsController < ApplicationController

  def index
    if params[:category].present?
      if params[:category] == 'product'
        items = Product.where('product_type = ?', params[:category]).joins(:category).joins(:brand).limit(8)
      else
        items = Product.where('product_type = ?', params[:category]).joins(:category).limit(8)
      end
    else
      items = Product.all.joins(:category).joins(:brand).limit(8)
    end

    if params[:search].present?
      if params[:category] == 'product'
        items = items.where("products.name like '%#{params[:search]}%' or categories.name like '%#{params[:search]}%' or brands.name like '%#{params[:search]}%'")
      else
        items = items.where("products.name like '%#{params[:search]}%' or categories.name like '%#{params[:search]}%'")
      end
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
    # if params[:category] == 'service'
    #   render 'services'
    # end
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
    if params[:category].present?
      if params[:category] == 'product'
        items = Product.where('product_type = ?', params[:category]).joins(:category).joins(:brand).limit(5).offset(params[:offset])
      else
        items = Product.where('product_type = ?', params[:category]).joins(:category).limit(5).offset(params[:offset])
      end
    else
      items = Product.all.joins(:category).joins(:brand).limit(5).offset(params[:offset])
    end

    if params[:search].present?
      if params[:category] == 'product'
        items = items.where("products.name like '%#{params[:search]}%' or categories.name like '%#{params[:search]}%' or brands.name like '%#{params[:search]}%'")
      else
        items = items.where("products.name like '%#{params[:search]}%' or categories.name like '%#{params[:search]}%'")
      end
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
