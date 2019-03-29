class AddStripCssToProductCrawlers < ActiveRecord::Migration[5.0]
  def change
    add_column :product_crawlers, :strip_css, :string
  end
end
