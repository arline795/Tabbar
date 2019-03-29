class AddProductCrawlerToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :product_crawler_id, :integer
    add_index :products, :product_crawler_id
  end
end
