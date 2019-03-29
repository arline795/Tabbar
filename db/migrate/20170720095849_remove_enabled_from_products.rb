class RemoveEnabledFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :enabled, :boolean
  end
end
