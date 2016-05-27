class OrdersController < ApplicationController

  def index
    @orders = Order.all.where(:user_id => current_user.id)
    @categories = Product.all.group('category_id').count
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if current_user.present?
      @order.user_id = current_user.id
      @order.email = current_user.email
    end
    @order.status_id = Order::ORDER_STATE[:placed]
    if @order.save
      @order.add_to_line_item(current_cart)
      current_cart.delete
      session.delete(:cart_id)
    end
    if current_user.present?
      redirect_to orders_path
    else
      redirect_to root_path
    end

  end

  private
  def order_params
    params.require(:order).permit!
  end

end
