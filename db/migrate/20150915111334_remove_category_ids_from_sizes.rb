class RemoveCategoryIdsFromSizes < ActiveRecord::Migration
  def change
    remove_column :sizes, :category_id, :integer
  end
end
