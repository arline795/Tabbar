class RenameTableCategorySizes < ActiveRecord::Migration
  def change
    rename_table :category_sizes, :categories_sizes
  end
end
