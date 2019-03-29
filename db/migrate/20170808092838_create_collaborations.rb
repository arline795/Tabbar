class CreateCollaborations < ActiveRecord::Migration[5.0]
  def change
    create_table :collaborations do |t|
      t.references :requester, references: :user, index: true, null: false
      t.references :receiver, references: :user, index: true, null: false
      t.timestamps
    end
  end
end
