class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.integer :outfit_user_id
      t.references :product, index: true
      t.string :product_name
      t.integer :product_price_in_cents
      t.string :size
      t.integer :quantity
      t.integer :shipping_price_in_cents
      t.string :shipping_method
      t.string :shipping_address
      t.string :aasm_state
      t.string :invoice_id

      t.timestamps null: false
    end
    add_foreign_key :orders, :users
    add_foreign_key :orders, :products
  end
end
