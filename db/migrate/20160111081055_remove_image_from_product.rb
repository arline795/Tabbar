class RemoveImageFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :product_image_file_name, :string
    remove_column :products, :product_image_content_type, :string
    remove_column :products, :product_image_file_size, :integer
    remove_column :products, :product_image_updated_at, :datetime
  end
end
