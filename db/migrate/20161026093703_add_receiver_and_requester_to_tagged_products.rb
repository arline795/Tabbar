class AddReceiverAndRequesterToTaggedProducts < ActiveRecord::Migration
  def change
    add_reference :tagged_products, :receiver, references: :users, index: true, foreign_key: true
    add_reference :tagged_products, :requester, references: :users, index: true, foreign_key: true
  end
end
