class AddCategoriesContainerCssAndCategoryCssToProductCrawlers < ActiveRecord::Migration[5.0]
  def change
    add_column :product_crawlers, :categories_container_css, :string
    add_column :product_crawlers, :category_css, :string
  end
end
