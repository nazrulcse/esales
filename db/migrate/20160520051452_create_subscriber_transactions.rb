class CreateSubscriberTransactions < ActiveRecord::Migration
  def change
    create_table :subscriber_transactions do |t|
      t.integer :user_id
      t.string :chanel
      t.float :amount
      t.string :mobile
      t.string :bank
      t.text :address
      t.integer :status

      t.timestamps null: false
    end
  end
end
