class AddPriceInCentsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price_in_cents, :integer
  end
end
