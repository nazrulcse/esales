class ServicesController < ApplicationController
  def index
    @services = Service.all.limit(8)
    if params[:category_id].present?
      @services = @services.where(category_id: params[:category_id])
    end

    if params[:max_price].present?
      @services = @services.where('price BETWEEN ? AND ?', params[:min_price], params[:max_price])
    end

    if params[:tag].present?
      @services = Service.tagged_with(params[:tag])
    end
    @categories = Service.group('category_id').count
  end


  def show
    @service = Service.find_by_slug(params[:id])
    @categories = Service.group('category_id').count
    @reviews = @service.reviews
  end

  def review
    service = Service.find_by_slug(params["id"])
    service_review = service.reviews.build(user_id: current_user.id)
    service_review.comment = params["comment"]
    service_review.save
  end

  def more
    if params[:category].present?
      if params[:category] == 'product'
        items = Product.where('product_type = ?', params[:category]).joins(:category).joins(:brand).limit(5).offset(params[:offset])
      else
        items = Product.where('product_type = ?', params[:category]).joins(:category).limit(5).offset(params[:offset])
      end
    else
      items = Product.all.joins(:category).where('product_type = ?', 'service').limit(5).offset(params[:offset])
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

    if params[:tag].present?
      items = Product.tagged_with(params[:tag])
    end

    @categories = items.group('category_id').count
    @services = items
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
end
