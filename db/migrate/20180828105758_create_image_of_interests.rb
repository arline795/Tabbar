class CreateImageOfInterests < ActiveRecord::Migration[5.0]
  def change
    create_table :image_of_interests do |t|
      t.attachment :image
      t.references :user, foreign_key: true
      t.string :uuid, index: true, null: false
      t.timestamps
    end
  end
end
