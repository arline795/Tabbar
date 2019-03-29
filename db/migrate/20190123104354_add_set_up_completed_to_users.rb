class AddSetUpCompletedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :set_up_completed, :boolean, default: false
  end
end
