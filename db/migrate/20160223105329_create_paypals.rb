class CreatePaypals < ActiveRecord::Migration
  def change
    create_table :paypals do |t|
      t.string :email
      t.references :user, index: true
      t.boolean :default

      t.timestamps null: false
    end
    add_foreign_key :paypals, :users
  end
end
