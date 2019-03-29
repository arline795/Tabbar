class AddEnabledToProducts < ActiveRecord::Migration
  def change
    add_column :products, :enabled, :boolean, default: true
  end
end
