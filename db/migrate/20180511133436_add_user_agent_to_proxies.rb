class AddUserAgentToProxies < ActiveRecord::Migration[5.0]
  def change
    add_column :proxies, :user_agent, :string
  end
end
