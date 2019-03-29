class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.boolean :default_devlivery_address
      t.boolean :default_billing_address
      t.string :address_line_1
      t.string :address_line_2
      t.string :suburb
      t.string :state
      t.string :postcode
      t.string :country
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :addresses, :users
  end
end
