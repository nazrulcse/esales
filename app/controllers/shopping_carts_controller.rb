class ShoppingCartsController < ApplicationController
  def index
    @cart = ShoppingCart.find_by_id(session[:cart_id])
  end

  def empty_cart
    current_cart.delete
    session.delete(:cart_id)
    redirect_to products_path
  end
end

