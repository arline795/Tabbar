class AddAttachmentImageToCroppedProducts < ActiveRecord::Migration
  def self.up
    change_table :cropped_products do |t|
      t.attachment :image, null: :false
    end
  end

  def self.down
    remove_attachment :cropped_products, :image
  end
end
