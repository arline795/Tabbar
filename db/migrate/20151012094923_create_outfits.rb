class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.text :description
      t.attachment :outfit_image
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
