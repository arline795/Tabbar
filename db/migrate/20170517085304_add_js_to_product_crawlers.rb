class AddJsToProductCrawlers < ActiveRecord::Migration[5.0]
  def change
    add_column :product_crawlers, :js, :boolean, default: false
  end
end
