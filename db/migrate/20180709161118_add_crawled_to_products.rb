class AddCrawledToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :crawled, :boolean, default: false
    add_index :products, :crawled
  end
end
