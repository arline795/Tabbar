class RecreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :ancestry, index: true

      t.timestamps
    end
  end
end
