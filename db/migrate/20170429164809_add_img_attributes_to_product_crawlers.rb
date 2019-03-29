class AddImgAttributesToProductCrawlers < ActiveRecord::Migration[5.0]
  def change
    add_column :product_crawlers, :image_css, :string
    add_column :product_crawlers, :image_attribute, :string
    add_column :product_crawlers, :image_regex, :string
  end
end
