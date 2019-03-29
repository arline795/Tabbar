class AddCaptionToOutfits < ActiveRecord::Migration
  def change
    add_column :outfits, :caption, :string
  end
end
