class AddPaginatedToProductCrawlers < ActiveRecord::Migration[5.0]
  def change
    add_column :product_crawlers, :paginated, :boolean, default: false
  end
end
