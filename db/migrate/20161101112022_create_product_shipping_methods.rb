class CreateProductShippingMethods < ActiveRecord::Migration
  def change
    create_table :product_shipping_methods do |t|
      t.references :product, index: true
      t.references :shipping_method, index: true

      t.timestamps null: false
    end
    add_foreign_key :product_shipping_methods, :products
    add_foreign_key :product_shipping_methods, :shipping_methods
  end
end
