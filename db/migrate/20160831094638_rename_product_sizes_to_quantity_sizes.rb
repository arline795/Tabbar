class RenameProductSizesToQuantitySizes < ActiveRecord::Migration
  def change
    rename_table :product_sizes, :quantity_sizes
  end
end
