class CreateWebhoseCrawlers < ActiveRecord::Migration[5.0]
  def change
    create_table :webhose_crawlers do |t|
      t.references :user, foreign_key: true, null: false
      t.string :base_url

      t.timestamps
    end
  end
end
