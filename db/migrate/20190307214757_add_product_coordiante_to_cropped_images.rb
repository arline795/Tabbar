class AddProductCoordianteToCroppedImages < ActiveRecord::Migration[5.0]
  def change
    add_column :cropped_images, :product_coordinate, :json
  end
end
