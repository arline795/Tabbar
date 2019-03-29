class AddCroppedImageToProductImages < ActiveRecord::Migration[5.0]
  def up
    add_attachment :product_images, :cropped_image
  end

  def down
    remove_attachment :product_images, :cropped_image
  end
end
