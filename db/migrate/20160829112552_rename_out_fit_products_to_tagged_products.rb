class RenameOutFitProductsToTaggedProducts < ActiveRecord::Migration
  def change
    rename_table :outfit_products, :tagged_products
  end
end
