class AddBaseUrlToProductCrawlers < ActiveRecord::Migration[5.0]
  def change
    add_column :product_crawlers, :base_url, :string
  end
end
