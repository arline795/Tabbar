class AddAaaToProducts < ActiveRecord::Migration
  def change
    add_column :products, :archive_number, :string
    add_column :products, :archived_at, :datetime
  end
end
