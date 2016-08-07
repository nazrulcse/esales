class TravelsController < ApplicationController
  before_action :set_travel

  def index
    @travels = Travel.all
  end

  def show

  end

  private

  def set_travel
    @travel = Travel.find_by_slug(params[:id])
  end
end
