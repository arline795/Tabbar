class AddViglinkCategoryToCrawlCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :crawl_categories, :viglink_category, :string
  end
end
