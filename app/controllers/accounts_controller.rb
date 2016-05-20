class AccountsController < ApplicationController

  def account
    @orders = current_user.orders
    @earnings = current_user.sales
    @transactions = current_user.subscriber_transactions
    @pending = current_user.orders.where("status_id != ?", SubscriberTransaction::TRANSACTION_STATE[:complete])
    @transaction = SubscriberTransaction.new
  end
end
