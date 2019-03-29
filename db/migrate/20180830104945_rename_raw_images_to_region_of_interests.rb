class RenameRawImagesToRegionOfInterests < ActiveRecord::Migration[5.0]
  def change
    rename_table :raw_images, :cropped_images
    add_reference :cropped_images, :image_of_interest, index: true
  end
end
