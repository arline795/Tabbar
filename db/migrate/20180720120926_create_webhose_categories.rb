class CreateWebhoseCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :webhose_categories do |t|
      t.references :category, foreign_key: true, null: false
      t.references :webhose_crawler, foreign_key: true, null: false
      t.string :query

      t.timestamps
    end
  end
end
