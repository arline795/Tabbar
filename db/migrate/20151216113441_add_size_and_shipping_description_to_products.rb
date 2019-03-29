class AddSizeAndShippingDescriptionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :size_description, :text
    add_column :products, :shipping_description, :text
  end
end
