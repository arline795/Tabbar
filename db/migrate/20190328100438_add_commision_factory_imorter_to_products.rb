class AddCommisionFactoryImorterToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :commission_factory_category, foreign_key: true
  end
end
