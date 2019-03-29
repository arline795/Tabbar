class AddUserToProductCrawlers < ActiveRecord::Migration[5.0]
  def change
    add_reference :product_crawlers, :user, foreign_key: true
  end
end
