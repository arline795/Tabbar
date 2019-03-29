class AddRedirectUrlToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :redirect_url, :string
  end
end
