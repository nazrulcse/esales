class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :date
      t.integer :cart_id
      t.date :shipment_date

      t.timestamps null: false
    end
  end
end
