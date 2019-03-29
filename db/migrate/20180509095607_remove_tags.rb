class RemoveTags < ActiveRecord::Migration[5.0]
  def change
    drop_table :taggings
    drop_table :tags
  end
end
