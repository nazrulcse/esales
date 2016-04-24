class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.integer :order_id
      t.float :price
      t.integer :total_quantity
      t.float :discount

      t.timestamps null: false
    end
  end
end
