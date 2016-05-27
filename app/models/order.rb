class Order < ActiveRecord::Base
  ORDER_STATE = {
      :reject => 0,
      :placed => 1,
      :delivery => 2,
      :delivered => 3
  }
  belongs_to :user
  has_many :line_items

  def add_to_line_item(current_cart)
    current_cart.line_items.each do |item|
      line_items << item
    end
  end

  def self.order_total(order)
    total = 0
    order.line_items.each do |line_item|
    total = total + line_item.total_price
    end
    return total
  end

  def self.earning(line_item)
    product = Product.find_by_id(line_item.product_id)
    earning = (product.price.to_f * product.subscriber_discount.to_f * line_item.quantity.to_f) / 100
    return earning
  end

  def self.get_price(line_item)
    product = Product.find_by_id(line_item.product_id)
    price = (product.price * line_item.quantity)
    return price
  end
end
