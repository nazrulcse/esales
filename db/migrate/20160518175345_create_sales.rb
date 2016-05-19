class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :product_id
      t.integer :user_id
      t.integer :order_id
      t.float :discount
      t.float :price
      t.float :earning

      t.timestamps null: false
    end
  end
end
