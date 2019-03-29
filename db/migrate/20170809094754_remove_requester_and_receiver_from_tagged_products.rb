class RemoveRequesterAndReceiverFromTaggedProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :tagged_products, :receiver_id
    remove_column :tagged_products, :requester_id
  end
end
