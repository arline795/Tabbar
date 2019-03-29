class CreateCommissionFactoryCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :commission_factory_categories do |t|
      t.references :category, foreign_key: true, null: false
      t.references :commission_factory_importer, foreign_key: true, null: false, index: { name: "index_commission_factory_categories_on_commission_factory_id"}
      t.string :query

      t.timestamps
    end
  end
end
