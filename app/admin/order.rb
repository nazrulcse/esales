ActiveAdmin.register Order do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  index do
    selectable_column
    column :is_guest
    column :name
    column :email
    column :mobile
    column :city
    column :zip
    column :address
    column :price do |order|
      number_to_currency Order.order_total(order)
    end

    column 'Status'  do |t|
      span 'Delivered'  if t.status_id == Order::ORDER_STATE[:delivered]
      span link_to 'Delivery',   delivery_admin_order_path(t) , class: 'status-button'  if t.status_id == Order::ORDER_STATE[:placed]
      span link_to 'Accept',   accept_admin_order_path(t) , class: 'status-button'  if t.status_id == Order::ORDER_STATE[:delivery]
      span link_to 'Reject',   reject_admin_order_path(t), class: 'status-button' if t.status_id == Order::ORDER_STATE[:delivery]
    end
    actions
  end

  show do
    render 'order_list', order: order
  end


  member_action :delivery, method: :get do
   order = Order.find_by_id(params[:id])
   order.status_id = Order::ORDER_STATE[:delivery]
   order.save
   redirect_to admin_orders_path, notice: "Order successfully send  for delivery"

  end

  member_action :reject, method: :get do
    order = Order.find_by_id(params[:id])
    order.status_id = Order::ORDER_STATE[:reject]
    order.save
    redirect_to admin_orders_path, notice: "Order successfully Rejected"
  end

  member_action :accept, method: :get do
    order = Order.find_by_id(params[:id])
    order.status_id = Order::ORDER_STATE[:delivered]
    order.save
    order.line_items.each do |line_item|
      Sale.create(product_id: line_item.product_id, order_id: order.id,quantity: line_item.quantity, user_id: order.user_id, price: Order.get_price(line_item), discount: Product.find_by_id(line_item.product_id).subscriber_discount, earning: Order.earning(line_item))
    end
    redirect_to admin_orders_path, notice: "Order successfully Delivered"
  end


end
