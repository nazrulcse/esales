class AccountsController < ApplicationController
  before_action :authenticate_user!

  def account
    @orders = current_user.orders
    @earnings = current_user.sales
    @transactions = current_user.subscriber_transactions
    @pending = current_user.orders.where('status_id != ?', Order::ORDER_STATE[:delivered])
    @transaction = SubscriberTransaction.new
    last_transaction = @transactions.where(status: SubscriberTransaction::TRANSACTION_STATE[:complete]).last
    @last_transaction_amount = last_transaction.amount if last_transaction.present?
  end
end
