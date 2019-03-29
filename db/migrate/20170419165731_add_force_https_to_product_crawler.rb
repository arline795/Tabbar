class AddForceHttpsToProductCrawler < ActiveRecord::Migration[5.0]
  def change
    add_column :product_crawlers, :force_https, :boolean, default: false
  end
end
