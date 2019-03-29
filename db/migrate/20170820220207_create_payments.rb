class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :sender, references: :user, index: true, null: false
      t.references :receiver, references: :user, index: true, null: false
      t.references :collaboration, references: :collaboration, index: true, null: false
      t.integer :payment_in_cents, default: 0, null: false
      t.timestamps
    end
  end
end
