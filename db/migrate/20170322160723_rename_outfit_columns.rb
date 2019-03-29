class RenameOutfitColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :medias, :outfit_image_file_name, :media_image_file_name
    rename_column :medias, :outfit_image_content_type, :media_image_content_type
    rename_column :medias, :outfit_image_file_size, :media_image_file_size
    rename_column :medias, :outfit_image_updated_at, :media_image_updated_at
    rename_column :orders, :outfit_user_id, :media_user_id
  end
end
