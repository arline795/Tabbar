class AddSizesToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :sizes, :integer, array: true
  end
end