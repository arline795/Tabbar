class RenameOutfitContainedTables < ActiveRecord::Migration[5.0]
  def change
    rename_table :outfit_similar_products, :media_similar_products
  end
end
