class TravelsController < ApplicationController
  before_action :set_travel

  def index
    @travels = Travel.all
    if params[:max_price].present?
      @travels = @travels.where('price BETWEEN ? AND ?', params[:min_price], params[:max_price])
    end

    if params[:key_words].present?
      arr_range = params['key_words'].split('To')
      @travels = @travels.where("from_date >= ? AND to_date <= ?",arr_range.first.to_date,arr_range.last.to_date)
    end

    if params[:vehicle_id].present?
      @travels = @travels.where(vehicle_id: params[:vehicle_id])
    end

    if params[:tag].present?
      @travels = Travel.tagged_with(params[:tag])
    end
  end

  def show
    @reviews = @travel.reviews
  end

  def review
    travel = Travel.find_by_slug(params["id"])
    travel_review = travel.reviews.build(user_id: current_user.id)
    travel_review.comment = params["comment"]
    travel_review.save
  end

  private

  def set_travel
    @travel = Travel.find_by_slug(params[:id])
  end
end
