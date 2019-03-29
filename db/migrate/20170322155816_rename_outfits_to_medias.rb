class RenameOutfitsToMedias < ActiveRecord::Migration[5.0]
  def change
    rename_table :outfits, :medias
  end
end
