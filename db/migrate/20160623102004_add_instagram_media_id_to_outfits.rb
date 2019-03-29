class AddInstagramMediaIdToOutfits < ActiveRecord::Migration
  def change
    add_column :outfits, :instagram_media_id, :string
  end
end
