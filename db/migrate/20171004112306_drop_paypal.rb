class DropPaypal < ActiveRecord::Migration[5.0]
  def change
    drop_table :paypals
    drop_table :paypal_notifications, if_exists: true
  end
end
