class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.decimal :price, :decimal, :precision => 8, :scale => 2
      t.text :description

      t.timestamps null: false
    end
  end
end
