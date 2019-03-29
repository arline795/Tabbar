class ChangeTrackingCodeToString < ActiveRecord::Migration
  def change
    change_column :orders, :tracking_code, :string
  end
end
