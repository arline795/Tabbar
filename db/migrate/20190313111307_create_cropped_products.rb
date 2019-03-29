class CreateCroppedProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :cropped_products do |t|
      t.references :image_of_interest, foreign_key: true, null: :false

      t.timestamps
    end
  end
end
