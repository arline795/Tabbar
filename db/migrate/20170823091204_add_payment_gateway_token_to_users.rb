class AddPaymentGatewayTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :payment_gateway_token, :string
  end
end
