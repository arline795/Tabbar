class CreateProductSizes < ActiveRecord::Migration
  def change
    create_table :product_sizes do |t|
      t.integer :quantity
      t.references :product, index: true, foreign_key: true
      t.references :size, index: true, foreign_key: true
    end
  end
end
