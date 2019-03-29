class DropWebhoseTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :webhose_categories
    drop_table :webhose_crawlers
  end
end
