class RenameOutfitsForeignKeys < ActiveRecord::Migration[5.0]
  def change
    rename_column :cart_items, :outfit_id, :media_id
    rename_column :comments, :outfit_id, :media_id
    rename_column :likes, :outfit_id, :media_id
    rename_column :outfit_similar_products, :outfit_id, :media_id
    rename_column :tagged_products, :outfit_id, :media_id
  end
end
