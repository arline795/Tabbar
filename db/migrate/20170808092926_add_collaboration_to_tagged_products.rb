class AddCollaborationToTaggedProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :tagged_products, :collaboration, foreign_key: true, index: true
  end
end
