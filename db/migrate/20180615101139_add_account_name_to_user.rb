class AddAccountNameToUser < ActiveRecord::Migration[5.0]
  def self.up
    add_column :users, :account_name, :string, unique: true
    User.all.each do |u|
      account_name = u.username
      u.update(account_name: account_name)
    end
  end

  def self.down
    remove_column :users, :account_name, :string, null: false
  end
end
