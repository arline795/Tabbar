class RenameOrderTableToCartTable < ActiveRecord::Migration
  def change
    rename_table :orders, :carts
  end
end
