class AddAttachmentProductImageToProductImages < ActiveRecord::Migration
  def self.up
    change_table :product_images do |t|
      t.attachment :product_image
    end
  end

  def self.down
    remove_attachment :product_images, :product_image
  end
end
