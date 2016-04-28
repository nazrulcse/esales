class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :shopping_cart
  belongs_to :order


  def total_price
    quantity * product.price
  end
end
