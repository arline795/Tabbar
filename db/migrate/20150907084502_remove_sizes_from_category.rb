class RemoveSizesFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :sizes, :integer
  end
end
