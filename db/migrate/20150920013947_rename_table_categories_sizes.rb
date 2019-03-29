class RenameTableCategoriesSizes < ActiveRecord::Migration
  def change
    rename_table :categories_sizes, :category_sizes
  end
end
