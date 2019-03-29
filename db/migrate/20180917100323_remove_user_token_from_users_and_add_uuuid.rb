class RemoveUserTokenFromUsersAndAddUuuid < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :token, :string
    add_column :users, :uuid, :string
  end
end
