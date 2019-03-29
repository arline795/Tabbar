class RenameImagesToProductImages < ActiveRecord::Migration
  def change
    rename_column :products, :image_file_name, :product_image_file_name
    rename_column :products, :image_content_type, :product_image_content_type
    rename_column :products, :image_file_size, :product_image_file_size
    rename_column :products, :image_updated_at, :product_image_updated_at
  end
end
