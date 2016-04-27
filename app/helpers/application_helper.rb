module ApplicationHelper

  def line_items_count
    cart_id = session[:cart_id]
    cart = ShoppingCart.find_by_id(cart_id)
    cart.line_items.count if cart.present?
  end

end
