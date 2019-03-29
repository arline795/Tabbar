class AddSizesIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :size_ids, :integer
  end
end
