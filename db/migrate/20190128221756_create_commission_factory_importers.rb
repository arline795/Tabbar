class CreateCommissionFactoryImporters < ActiveRecord::Migration[5.0]
  def change
    create_table :commission_factory_importers do |t|
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
