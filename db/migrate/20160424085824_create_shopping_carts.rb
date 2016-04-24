class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.integer :product_id
      t.integer :quantity
      t.float :total_price

      t.timestamps null: false
    end
  end
end
