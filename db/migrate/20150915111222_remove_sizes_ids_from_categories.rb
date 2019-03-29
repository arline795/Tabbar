class RemoveSizesIdsFromCategories < ActiveRecord::Migration
  def up
    drop_table :sizes
  end
end
