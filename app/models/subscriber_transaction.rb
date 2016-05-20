class SubscriberTransaction < ActiveRecord::Base

  TRANSACTION_STATE = {
      :reject => 0,
      :placed => 1,
      :complete => 2
  }

  CHANEL = {
      :bank => 'Bank',
      :bkash => 'Bkash'
  }

  belongs_to :user

  def self.available_money(user_id)
    user = User.find_by_id(user_id)
    @transactions = user.subscriber_transactions
    @earnings = user.sales
    if @transactions.present?
      @complete_amount = @transactions.where(status: SubscriberTransaction::TRANSACTION_STATE[:complete]).sum(:amount)
    else
      @complete_amount = 0
    end
    @available_money = @earnings.sum(:earning) - @complete_amount
  end
end
