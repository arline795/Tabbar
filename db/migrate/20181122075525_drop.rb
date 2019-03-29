class Drop < ActiveRecord::Migration[5.0]
  def change
    drop_table :active_admin_comments
    drop_table :collaborations
    drop_table :comments
    drop_table :media_similar_products
    drop_table :medias
    drop_table :relationships
  end
end
