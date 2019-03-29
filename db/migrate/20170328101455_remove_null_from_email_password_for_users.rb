class RemoveNullFromEmailPasswordForUsers < ActiveRecord::Migration[5.0]
  def self.up
    change_column :users, :email, :string, default: nil, null: true
    change_column :users, :encrypted_password, :string, default: nil, null: true
  end

  def self.down
    change_column :users, :email, :string, default: nil, null: false
    change_column :users, :encrypted_password, :string, default: nil, null: false
  end
end
