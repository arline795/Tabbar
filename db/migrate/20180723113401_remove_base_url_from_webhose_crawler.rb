class RemoveBaseUrlFromWebhoseCrawler < ActiveRecord::Migration[5.0]
  def change
    remove_column :webhose_crawlers, :base_url, :string
  end
end
