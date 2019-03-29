class RemoveFieldsFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :size_description
    remove_column :products, :shipping_description
    remove_column :products, :category_id
  end
end
