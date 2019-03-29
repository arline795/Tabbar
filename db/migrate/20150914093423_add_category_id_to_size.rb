class AddCategoryIdToSize < ActiveRecord::Migration
  def change
    add_column :sizes, :category_id, :integer
  end
end
