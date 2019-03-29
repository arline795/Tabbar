class RemoveArchiveNumberAndArchivedAtFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :archive_number, :string
    remove_column :products, :archived_at, :datetime
  end
end
