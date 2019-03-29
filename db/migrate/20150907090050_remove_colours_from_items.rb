class RemoveColoursFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :colours, :integer
  end
end
