class AddUuidToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :uuid, :string

    Product.all.each{|p| p.update(uuid: SecureRandom.uuid)}

    change_column :products, :uuid, :string, null:false
  end
end
