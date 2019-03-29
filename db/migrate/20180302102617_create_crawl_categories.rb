class CreateCrawlCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :crawl_categories do |t|
      t.references :category, foreign_key: true
      t.references :product_crawler, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
