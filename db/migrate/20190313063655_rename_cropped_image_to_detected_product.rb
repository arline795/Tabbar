class RenameCroppedImageToDetectedProduct < ActiveRecord::Migration[5.0]
  def change
    rename_table :cropped_images, :detected_products
  end
end
