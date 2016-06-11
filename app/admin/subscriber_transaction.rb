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
    column 'Status' do |t|
      span 'Complete' if t.status == SubscriberTransaction::TRANSACTION_STATE[:complete]
      span 'Reject' if t.status == SubscriberTransaction::TRANSACTION_STATE[:reject]
      span link_to 'Accept', accept_admin_subscriber_transaction_path(t), class: 'status-button' if t.status ==SubscriberTransaction::TRANSACTION_STATE[:placed]
      span link_to 'Reject', reject_admin_subscriber_transaction_path(t), class: 'status-button' if t.status == SubscriberTransaction::TRANSACTION_STATE[:placed]
    end
    actions
  end


  member_action :reject, method: :get do
    transaction = SubscriberTransaction.find_by_id(params[:id])
    transaction.status = SubscriberTransaction::TRANSACTION_STATE[:reject]
    transaction.save
    redirect_to admin_subscriber_transactions_path, notice: "Transaction successfully Rejected"
  end

  member_action :accept, method: :get do
    transaction = SubscriberTransaction.find_by_id(params[:id])
    transaction.status = SubscriberTransaction::TRANSACTION_STATE[:complete]
    transaction.save
    redirect_to admin_subscriber_transactions_path, notice: "Transaction successfully Accepted"
  end


end
