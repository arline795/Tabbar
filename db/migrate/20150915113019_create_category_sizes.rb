class CreateCategorySizes < ActiveRecord::Migration
  def change
    create_table :category_sizes do |t|
      t.belongs_to :category, index: true
      t.belongs_to :size, index: true

      t.timestamps null: false
    end
  end
end