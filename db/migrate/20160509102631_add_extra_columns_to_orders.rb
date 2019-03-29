class AddExtraColumnsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :product_user_id, :integer
    add_column :orders, :shipping_code, :string
  end
end
