class AddTokenToPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :token, :string, null: false
  end
end
