class ChangeProductCrawlers < ActiveRecord::Migration[5.0]
  def change
    remove_column :product_crawlers, :name
    remove_column :product_crawlers, :sitemap_url
    remove_column :product_crawlers, :match_url_regex
    remove_column :product_crawlers, :except_url_regex
    remove_column :product_crawlers, :categories_container_css
    remove_column :product_crawlers, :category_css
    remove_column :product_crawlers, :force_https
    add_column :product_crawlers, :product_link_css, :string
    add_column :product_crawlers, :load_more_css, :string
  end
end
