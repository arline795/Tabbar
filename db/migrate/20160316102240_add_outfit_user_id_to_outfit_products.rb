class AddOutfitUserIdToOutfitProducts < ActiveRecord::Migration
  def change
    add_column :outfit_products, :outfit_user_id, :integer
  end
end
