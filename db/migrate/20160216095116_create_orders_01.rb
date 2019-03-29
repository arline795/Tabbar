class CreateOrders01 < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :quantity
      t.references :product, index: true
      t.references :outfit, index: true
      t.references :size, index: true
      t.references :user, index: true
      t.references :shipping_method, index: true

      t.timestamps null: false
    end
    add_foreign_key :orders, :products
    add_foreign_key :orders, :outfits
    add_foreign_key :orders, :sizes
    add_foreign_key :orders, :users
    add_foreign_key :orders, :shipping_method
  end
end
