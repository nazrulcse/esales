module ApplicationHelper

  def line_items_count
    cart_id = session[:cart_id]
    cart = ShoppingCart.find_by_id(cart_id)
    cart.line_items.count if cart.present?
  end
  def form_validation_message(obj)
    if obj.errors.any?
      html = "<div id='error_explanation'>"
      html << "<h2> #{pluralize(obj.errors.count, 'error')} prohibited this post from being saved:</h2> <ul>"
      obj.errors.full_messages.each do |message|
        html << "<li> <i class='fa fa-times-circle'></i> #{message} </li>"
      end
      html << '</ul></div>'
    else
      html = ''
    end
    raw(html)
  end
end
