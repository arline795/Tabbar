class AddIndexToItems < ActiveRecord::Migration
  def change
  	add_index :items, [:user_id, :created_at]
  end
end
