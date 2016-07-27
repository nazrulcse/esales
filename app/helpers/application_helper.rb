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

  def number_with_currency(number)
    number_to_currency(format_number(number))
  end

  def format_number(number)
    response = ''
    #return number unless session[:locale] == 'bn'
    if session[:locale].present? && session[:locale] == 'en'
      return number
    end
    number.to_s.split(//).each do |ch|
      ch = ch.to_s
      case ch
        when '0'
          response << '০'
        when '1'
          response << '১'
        when '2'
          response << '২'
        when '3'
          response << '৩'
        when '4'
          response << '৪'
        when '5'
          response << '৫'
        when '6'
          response << '৬'
        when '7'
          response << '৭'
        when '8'
          response << '৮'
        when '9'
          response << '৯'
        else
          response << ch
      end
    end
    response
  end

  def get_tag_path(tag,product_type)
    if product_type == 'product'
      return raw "<a href='/products?tag=#{tag.name}' class='f-tag b-tag'</i>#{tag.name} </a>"
    else
      return raw "<a href='/services?tag=#{tag.name}' class='f-tag b-tag'</i>#{tag.name} </a>"
    end
  end

  def product_images
    ProductImage.order('RAND()').limit(12)
  end

  def popular_product(product_type)
    @popular_products = Product.where(product_type: product_type).select("products.*, SUM(sales.quantity) sales_quantity").joins(:sales).group("products.id").order("sales_quantity DESC")
  end

  def slider_images
    Slider.all
  end

  def maximum_price
    Product.maximum("price")
  end
end
