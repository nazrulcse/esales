class AddSubscriberDiscountFieldToProducts < ActiveRecord::Migration
  def change
    add_column :products, :subscriber_discount, :float
  end
end
