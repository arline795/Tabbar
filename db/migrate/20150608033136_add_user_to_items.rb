class AddUserToItems < ActiveRecord::Migration
  def change
    add_reference :items, :user, index: true
    add_foreign_key :items, :users
  end
end
