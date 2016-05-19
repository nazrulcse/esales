class AccountsController < ApplicationController

  def account
    @orders = current_user.orders
    @earnings = current_user.sales
    @pending = current_user.orders.where("status_id != ?", Order::ORDER_STATE[:delivered])
  end
end
