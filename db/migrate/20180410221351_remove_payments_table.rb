class RemovePaymentsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :payments
  end
end
