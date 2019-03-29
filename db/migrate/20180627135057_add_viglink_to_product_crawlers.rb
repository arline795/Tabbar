class AddViglinkToProductCrawlers < ActiveRecord::Migration[5.0]
  def change
    add_column :product_crawlers, :viglink, :boolean, default: false
    add_index :product_crawlers, :viglink
  end
end
