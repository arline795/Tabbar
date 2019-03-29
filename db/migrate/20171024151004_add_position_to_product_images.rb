class AddPositionToProductImages < ActiveRecord::Migration[5.0]
  def change
    add_column :product_images, :position, :integer, default: 0
    add_index :product_images, :position
  end
end
