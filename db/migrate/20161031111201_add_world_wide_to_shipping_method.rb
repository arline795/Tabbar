class AddWorldWideToShippingMethod < ActiveRecord::Migration
  def change
    add_column :shipping_methods, :world_wide, :boolean, default: false
  end
end
