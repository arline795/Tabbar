class AddDirectUrlToProductImages < ActiveRecord::Migration[5.0]
  def change
    add_column :product_images, :direct_url, :string
  end
end
