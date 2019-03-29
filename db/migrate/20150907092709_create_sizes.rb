class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.text :title

      t.timestamps null: false
    end
  end
end
