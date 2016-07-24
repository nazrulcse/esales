class AddSenderNumberFieldToSubscriberTransactions < ActiveRecord::Migration
  def change
    add_column :subscriber_transactions, :sender_number, :string
    add_column :subscriber_transactions, :payslip, :string
  end
end
