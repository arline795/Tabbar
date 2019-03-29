class RemoveDescriptionFromOutfits < ActiveRecord::Migration
  def change
    remove_column :outfits, :description, :text
  end
end
