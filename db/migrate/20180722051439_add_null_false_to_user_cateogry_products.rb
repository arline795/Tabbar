class AddNullFalseToUserCateogryProducts < ActiveRecord::Migration[5.0]
  def change
    change_column :user_categories, :user_id, :integer, null: false
    change_column :user_categories, :category_id, :integer, null: false
  end
end
