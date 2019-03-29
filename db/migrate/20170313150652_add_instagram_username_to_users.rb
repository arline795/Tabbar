class AddInstagramUsernameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :instagram_username, :string
  end
end
