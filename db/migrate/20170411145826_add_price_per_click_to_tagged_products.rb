class AddPricePerClickToTaggedProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :tagged_products, :price_per_click_in_cents, :integer, index: true, default: 0
  end
end
