class FavoritesController < ApplicationController
  before_filter :authenticate_user!

  def create
    current_user.favorites.find_or_create_by(product_id: params[:product_id])
   end

  def delete_favorite
   favorite =  current_user.favorites.find_by_product_id(params[:product_id])
   favorite.destroy
  end
end
