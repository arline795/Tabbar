class RemoveTableMailboxerReceipts < ActiveRecord::Migration[5.0]
  def change
    drop_table :mailboxer_receipts
  end
end
