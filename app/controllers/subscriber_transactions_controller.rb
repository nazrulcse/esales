class SubscriberTransactionsController < ApplicationController

  def create
    transaction = current_user.subscriber_transactions.build(transaction_params)
    transaction.status = SubscriberTransaction::TRANSACTION_STATE[:placed]
    if transaction.save
      flash[:notice] = "Successfully created Transaction"
    else
      flash[:alert] = "Something went wrong, please try again!"
    end
    redirect_to account_path
  end

  private

  def transaction_params
    params.require(:subscriber_transaction).permit!
  end
end
