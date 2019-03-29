class CreateProductCrawlers < ActiveRecord::Migration[5.0]
  def change
    create_table :product_crawlers do |t|
      t.string :name, index: true
      t.string :sitemap_url
      t.string :match_url_regex
      t.string :except_url_regex
      t.string :location, index: true
      t.string :title_css
      t.string :price_css
      t.string :description_css

      t.timestamps
    end
  end
end
