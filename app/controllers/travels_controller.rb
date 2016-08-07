class TravelsController < ApplicationController
  before_action :set_travel

  def index
    @travels = Travel.all
    if params[:max_price].present?
      @travels = @travels.where('price BETWEEN ? AND ?', params[:min_price], params[:max_price])
    end

    if params[:tag].present?
      @travels = Travel.tagged_with(params[:tag])
    end
  end

  def show
    @reviews = @travel.reviews
  end

  private

  def set_travel
    @travel = Travel.find_by_slug(params[:id])
  end
end
