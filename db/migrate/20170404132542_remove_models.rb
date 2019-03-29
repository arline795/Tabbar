class RemoveModels < ActiveRecord::Migration[5.0]
  def change
    drop_table :orders
    drop_table :product_shipping_methods
    drop_table :shipping_methods
    drop_table :cart_items
    drop_table :sizes
    drop_table :quantity_sizes
    drop_table :categories
  end
end
