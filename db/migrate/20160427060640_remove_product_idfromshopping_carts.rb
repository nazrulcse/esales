class RemoveProductIdfromshoppingCarts < ActiveRecord::Migration
  def change
    remove_column :shopping_carts, :product_id
    remove_column :shopping_carts, :quantity
    remove_column :shopping_carts, :total_price
  end
end
