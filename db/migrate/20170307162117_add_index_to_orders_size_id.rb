class AddIndexToOrdersSizeId < ActiveRecord::Migration
  def change
    add_index :orders, :size_id
  end
end
