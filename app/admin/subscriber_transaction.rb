ActiveAdmin.register SubscriberTransaction do

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

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    column :chanel
    column :amount
    column :remaining_amount do |tr|
      SubscriberTransaction.available_money(tr.user_id)
    end
    column :mobile
    column :bank
    column :address
    column :sender_number
    column :payslip do |p|
      image_tag(p.payslip.url,size: "40") if p.payslip.present?
    end
    column  'Status', colspan: 6 do |t|
      span 'Complete' if t.status == SubscriberTransaction::TRANSACTION_STATE[:complete]
      span 'Reject' if t.status == SubscriberTransaction::TRANSACTION_STATE[:reject]
      span link_to 'Accept', '#', class: 'status-button accept-transaction', :data => { :url => accept_admin_subscriber_transaction_path(t), chanel: t.chanel} if t.status ==SubscriberTransaction::TRANSACTION_STATE[:placed]
      span link_to 'Reject', reject_admin_subscriber_transaction_path(t), class: 'status-button reject-transaction' if t.status == SubscriberTransaction::TRANSACTION_STATE[:placed]
    end
    actions

    render partial: 'accept_transaction_modal'
  end


  member_action :reject, method: :get do
    transaction = SubscriberTransaction.find_by_id(params[:id])
    transaction.status = SubscriberTransaction::TRANSACTION_STATE[:reject]
    transaction.save
    redirect_to admin_subscriber_transactions_path, notice: "Transaction successfully Rejected"
  end

  member_action :accept, method: :post do
    transaction = SubscriberTransaction.find_by_id(params[:id])
    if params[:payslip].present?
      transaction.payslip = params[:payslip]
    end
    transaction.status = SubscriberTransaction::TRANSACTION_STATE[:complete]
    transaction.sender_number = params[:sender]
    transaction.save
    redirect_to admin_subscriber_transactions_path, notice: "Transaction successfully Accepted"
  end


end
