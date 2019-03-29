class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.references :product, index: true
    end
    add_foreign_key :product_images, :products
  end
end
