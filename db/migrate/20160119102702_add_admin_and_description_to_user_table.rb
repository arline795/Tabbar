class AddAdminAndDescriptionToUserTable < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :description, :text
  end
end
