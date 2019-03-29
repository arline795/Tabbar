class RemoveUserIdAndOutfitUserIdForTaggedProducts < ActiveRecord::Migration
  def change
    remove_column :tagged_products, :user_id, :integer
    remove_column :tagged_products, :outfit_user_id, :integer
    remove_column :tagged_products, :boolean, :boolean
  end
end
