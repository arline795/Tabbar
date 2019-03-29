class RemoveCollaborationIdFromPayments < ActiveRecord::Migration[5.0]
  def change
    remove_column :payments, :collaboration_id, :integer
  end
end
