class AddSizeIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :size_id, :integer
  end
end
