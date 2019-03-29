class CreateUserCategoryProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :user_category_products do |t|
      t.references :user_category, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
