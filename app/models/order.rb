class Order < ActiveRecord::Base
  ORDER_STATE = {
      :reject => 0,
      :pending => 1,
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
end
