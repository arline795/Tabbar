class DropCategoryProducts < ActiveRecord::Migration[5.0]
  def change
    drop_table :category_products
  end
end
