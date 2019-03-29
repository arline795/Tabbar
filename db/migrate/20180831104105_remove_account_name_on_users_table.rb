class RemoveAccountNameOnUsersTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :account_name, :string
  end
end
