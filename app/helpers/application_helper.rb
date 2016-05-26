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

  def generate_favorate_link(product_id)
    if current_user.present?
      favorite = current_user.favorites.find_by_product_id(product_id)
      if favorite.present?
        return raw "<a href='/favorites/delete_favorite?product_id=#{product_id}' id='fav_#{product_id}' class='b-btn f-btn b-btn-light f-btn-light info favorite' data-remote='true' > <i class='fa fa-heart'></i></a>"
      else
        return raw "<a href='/favorites?product_id=#{product_id}' id='fav_#{product_id}' class='b-btn f-btn b-btn-light f-btn-light info' data-method='post' data-remote='true' > <i class='fa fa-heart'></i></a>"
      end
    else
      return raw ('<a href="/users/sign_in" class="b-btn f-btn b-btn-light f-btn-light info"><i class="fa fa-heart"></i></a>')
    end
  end

 def get_category_name(category)
   Category.find_by_id(category).name
 end

  def get_tag_path(tagging)
    if tagging.taggable_type == 'Product'
      return raw "<a href='products?tag=#{tagging.tag.name}' class='f-tag b-tag'</i>#{tagging.tag.name} </a>"
    else
      return raw "<a href='services?tag=#{tagging.tag.name}' class='f-tag b-tag'</i>#{tagging.tag.name} </a>"
    end
  end

  def product_images
   ProductImage.order('RAND()').limit(12)
  end

  def popular_product(product_type)
    @popular_products = Product.where(product_type: product_type).select("products.*, SUM(sales.quantity) sales_quantity").joins(:sales).group("products.id").order("sales_quantity DESC")
  end
end
