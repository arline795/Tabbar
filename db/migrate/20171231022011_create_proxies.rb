class CreateProxies < ActiveRecord::Migration[5.0]
  def change
    create_table :proxies do |t|
      t.string :ip
      t.string :port
      t.string :user
      t.string :password

      t.timestamps
    end
  end
end
