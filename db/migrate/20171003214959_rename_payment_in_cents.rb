class RenamePaymentInCents < ActiveRecord::Migration[5.0]
  def change
    rename_column :payments, :payment_in_cents, :amount_in_cents
  end
end
