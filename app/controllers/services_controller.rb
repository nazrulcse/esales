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

    items = Service.all.joins(:category).limit(5).offset(params[:offset])

    if params[:search].present?
        items = items.where("services.name like '%#{params[:search]}%' or categories.name like '%#{params[:search]}%'")
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
